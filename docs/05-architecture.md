# 05 — Flutter Architecture

**Pattern:** Clean Architecture + Repository Pattern
**State management:** Riverpod 2.x (with `riverpod_generator`)
**Persistence:** drift (SQLite)

---

## 1. The Three Layers

```
┌──────────────────────────────────────────────────────────┐
│ PRESENTATION                                             │
│  Widgets / Screens  ──watch──▶  Riverpod Providers       │
│                                   │ call                  │
└───────────────────────────────────┼──────────────────────┘
                                     ▼
┌──────────────────────────────────────────────────────────┐
│ DOMAIN  (pure Dart, no Flutter)                          │
│  UseCases  ──▶  Repository (abstract interface)          │
│  Entities                                                 │
└───────────────────────────────────┼──────────────────────┘
                                     ▼ implemented by
┌──────────────────────────────────────────────────────────┐
│ DATA                                                     │
│  RepositoryImpl  ──▶  LocalDataSource  ──▶  drift (DB)    │
│  Models (DB ↔ Entity mapping)        ──▶  File storage    │
└──────────────────────────────────────────────────────────┘
```

**Golden rule:** dependencies point inward. Domain depends on nothing; Data and Presentation depend on Domain abstractions only.

---

## 2. Data Flow Example — "Add a Card"

```
[Add Card Screen]
   │ user taps Save
   ▼
ref.read(addCardControllerProvider.notifier).submit(form)
   │
   ▼
AddCardController (Riverpod Notifier)
   │ validates, builds Card entity
   ▼
AddCard usecase  ──▶  CardRepository.add(card)
                          │ (interface)
                          ▼
                   CardRepositoryImpl
                     1. ImageStorageService.persist(file) → path
                     2. map Card entity → CardModel
                     3. CardLocalDataSource.insert(model)
                          ▼
                       drift → SQLite INSERT
   ◀───────────────── Result<Card, Failure> bubbles back
   │
   ▼
Controller sets AsyncData → UI shows success / pops route
   │
   ▼
cardListProvider invalidated → Collection refreshes
```

---

## 3. Riverpod Provider Map

| Provider | Type | Responsibility |
|----------|------|----------------|
| `appDatabaseProvider` | `Provider<AppDatabase>` | Singleton drift DB |
| `cardLocalDataSourceProvider` | `Provider` | Wraps DB queries |
| `cardRepositoryProvider` | `Provider<CardRepository>` | Binds impl to interface |
| `imageStorageServiceProvider` | `Provider` | File save/delete/thumbnail |
| `permissionServiceProvider` | `Provider` | Camera/gallery runtime perms |
| `cardListProvider` | `AsyncNotifierProvider` | Filtered/sorted card list (reactive stream) |
| `cardFilterProvider` | `NotifierProvider<CardFilter>` | Current filter/sort/search state |
| `cardDetailProvider(id)` | `FutureProvider.family` | Single card + images + tags |
| `addCardControllerProvider` | `AsyncNotifierProvider` | Add/edit form submission |
| `wishlistProvider` | `AsyncNotifierProvider` | status='wishlist' cards |
| `dashboardSummaryProvider` | `FutureProvider` | Totals, per-game counts |
| `statisticsProvider` | `FutureProvider` | Aggregations for charts |
| `tagsProvider` | `AsyncNotifierProvider` | Tag CRUD |
| `settingsProvider` | `NotifierProvider` | Theme, currency, prefs |

**Reactivity:** drift exposes `.watch()` streams. `cardListProvider` watches a query built from `cardFilterProvider`, so any DB write or filter change auto-updates the UI — no manual refresh.

---

## 4. Domain Contracts (illustrative)

```dart
// domain/entities/card.dart  (pure)
class Card {
  final int? id;
  final GameType game;
  final String name;
  final String? setName;
  final String? cardNumber;
  final CardCondition condition;
  final int quantity;
  final CardStatus status;       // owned | wishlist
  final bool isFavorite;
  final double? purchasePrice;
  final double? currentValue;
  final String currency;
  final List<String> tags;
  final List<String> imagePaths;
  final String? notes;
  // ...
}

// domain/repositories/card_repository.dart  (abstract)
abstract interface class CardRepository {
  Stream<List<Card>> watchCards(CardFilter filter);
  Future<Result<Card>> getById(int id);
  Future<Result<int>> add(Card card);
  Future<Result<void>> update(Card card);
  Future<Result<void>> delete(int id);
  Future<Result<void>> toggleFavorite(int id);
  Future<DashboardSummary> getSummary();
  Future<CollectionStats> getStatistics();
}
```

```dart
// domain/usecases/add_card.dart
class AddCard {
  final CardRepository repo;
  AddCard(this.repo);
  Future<Result<int>> call(Card card) => repo.add(card);
}
```

---

## 5. Error Handling

* `Result<T>` (sealed) = `Success(T)` | `Error(Failure)`.
* `Failure` types: `DatabaseFailure`, `StorageFailure`, `PermissionFailure`, `ValidationFailure`.
* Presentation maps `Failure` → user-friendly snackbar/dialog text.
* No exceptions leak past the Data layer; datasources throw → repo catches → returns `Result`.

---

## 6. Image Storage Service

```
Camera/Gallery (image_picker)
        │ returns XFile (temp)
        ▼
ImageStorageService.persist(xfile, cardId)
  1. Decode + compress (≤ 1MB, JPEG q=85)
  2. Generate thumbnail (e.g. 256px)
  3. Copy to <app_docs>/cards/<cardId>/<uuid>.jpg
  4. Return CardImage{ filePath, thumbPath }
        ▼
Stored relative path in card_images table
```

* Files live in **app-private** documents dir (`path_provider`) — not user-visible gallery, survives uninstall? No (cleared on uninstall) → covered by export/backup.
* On card delete → cascade delete DB rows **and** orphan image files.

---

## 7. Navigation (go_router)

```
/                      → DashboardScreen
/collection            → CollectionScreen
/collection/:id        → CardDetailScreen
/wishlist              → WishlistScreen
/add                   → AddCardScreen (modal)
/add?editId=:id        → AddCardScreen (edit mode)
/statistics            → StatisticsScreen
/settings              → SettingsScreen
/settings/tags         → TagsManagerScreen
```

A `StatefulShellRoute` powers the bottom navigation with preserved state per tab.

---

## 8. Testing Strategy

| Test type | Target | Tooling |
|-----------|--------|---------|
| Unit | UseCases, mappers, repo impls | `mocktail` |
| DB integration | drift queries | in-memory `NativeDatabase.memory()` |
| Provider | Notifiers/AsyncNotifiers | `ProviderContainer` overrides |
| Widget | Screens, key widgets | `flutter_test` |
| Golden | Card tile, charts | `golden_toolkit` (optional) |

Dependency injection via Riverpod `overrides` makes every layer mockable.
