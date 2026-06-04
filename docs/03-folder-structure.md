# 03 — Folder Structure (Clean Architecture)

**Pattern:** Clean Architecture (Presentation → Domain → Data) + Feature-first
**State:** Riverpod (code-gen) · **DB:** drift · **DI:** Riverpod providers

---

## 1. High-Level Layers

```
Presentation  →  depends on  →  Domain  ←  implemented by  ←  Data
(UI, Riverpod)                 (pure Dart:                  (drift, files,
                                entities, repos             datasources)
                                interfaces, usecases)
```

**Dependency rule:** inner layers (Domain) know nothing about outer layers. Data and Presentation both depend on Domain abstractions.

---

## 2. Project Tree

```
card_vault/
├── android/
├── ios/
├── assets/
│   ├── icons/                 # game icons, app icon
│   └── images/
├── lib/
│   ├── main.dart
│   ├── app.dart               # MaterialApp + router + theme
│   │
│   ├── core/                  # cross-cutting, framework-level
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   └── game_types.dart
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   ├── app_colors.dart
│   │   │   └── app_typography.dart
│   │   ├── router/
│   │   │   └── app_router.dart        # go_router config
│   │   ├── database/
│   │   │   ├── app_database.dart       # drift @DriftDatabase
│   │   │   ├── tables/                 # drift table defs
│   │   │   └── migrations.dart
│   │   ├── error/
│   │   │   ├── failures.dart
│   │   │   └── exceptions.dart
│   │   ├── utils/
│   │   │   ├── result.dart             # Either/Result type
│   │   │   ├── image_utils.dart
│   │   │   └── currency_formatter.dart
│   │   ├── services/
│   │   │   ├── image_storage_service.dart
│   │   │   └── permission_service.dart
│   │   └── widgets/                    # shared UI atoms
│   │       ├── app_button.dart
│   │       ├── empty_state.dart
│   │       └── loading_indicator.dart
│   │
│   ├── features/
│   │   ├── collection/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── card_local_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── card_model.dart         # ↔ DB row
│   │   │   │   └── repositories/
│   │   │   │       └── card_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── card.dart               # pure entity
│   │   │   │   ├── repositories/
│   │   │   │   │   └── card_repository.dart    # abstract
│   │   │   │   └── usecases/
│   │   │   │       ├── add_card.dart
│   │   │   │       ├── update_card.dart
│   │   │   │       ├── delete_card.dart
│   │   │   │       ├── get_cards.dart
│   │   │   │       └── toggle_favorite.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── card_list_provider.dart
│   │   │       │   └── card_filter_provider.dart
│   │   │       ├── screens/
│   │   │       │   ├── collection_screen.dart
│   │   │       │   └── card_detail_screen.dart
│   │   │       └── widgets/
│   │   │           ├── card_tile.dart
│   │   │           └── filter_sheet.dart
│   │   │
│   │   ├── add_card/
│   │   │   ├── data/  · domain/ · presentation/
│   │   │   └── presentation/screens/add_card_screen.dart
│   │   │
│   │   ├── wishlist/
│   │   │   └── presentation/screens/wishlist_screen.dart
│   │   │
│   │   ├── dashboard/
│   │   │   ├── domain/usecases/get_dashboard_summary.dart
│   │   │   └── presentation/screens/dashboard_screen.dart
│   │   │
│   │   ├── statistics/
│   │   │   ├── domain/usecases/get_statistics.dart
│   │   │   └── presentation/
│   │   │       ├── providers/statistics_provider.dart
│   │   │       ├── screens/statistics_screen.dart
│   │   │       └── widgets/{value_chart.dart, rarity_pie.dart}
│   │   │
│   │   ├── tags/
│   │   │   ├── data/ · domain/ · presentation/
│   │   │   └── presentation/screens/tags_manager_screen.dart
│   │   │
│   │   └── settings/
│   │       ├── data/repositories/settings_repository_impl.dart
│   │       ├── domain/
│   │       └── presentation/screens/settings_screen.dart
│   │
│   └── shared/
│       ├── providers/
│       │   └── database_provider.dart   # exposes AppDatabase
│       └── models/
│
├── test/
│   ├── unit/                  # usecases, repositories
│   ├── widget/                # screens, widgets
│   └── integration/           # full flows (drift in-memory)
├── pubspec.yaml
└── analysis_options.yaml
```

---

## 3. Layer Responsibilities

| Layer | Knows about | Contains | Never imports |
|-------|-------------|----------|---------------|
| **Domain** | Nothing external | Entities, repo interfaces, usecases | Flutter, drift, Riverpod |
| **Data** | Domain | Models, datasources, repo impls | Presentation |
| **Presentation** | Domain | Screens, widgets, Riverpod providers | drift internals |

---

## 4. Naming Conventions

* Files: `snake_case.dart`
* Classes: `PascalCase`
* Providers: `cardListProvider`, `cardRepositoryProvider`
* Usecases: verb-first — `AddCard`, `GetCards`, `ToggleFavorite`
* Entities (domain) ≠ Models (data) — map explicitly in repo impl.

---

## 5. Key `pubspec.yaml` Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.5.0
  riverpod_annotation: ^2.3.0
  drift: ^2.18.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.1.0
  path: ^1.9.0
  go_router: ^14.0.0
  image_picker: ^1.1.0
  freezed_annotation: ^2.4.0
  fl_chart: ^0.68.0
  intl: ^0.19.0

dev_dependencies:
  build_runner: ^2.4.0
  drift_dev: ^2.18.0
  riverpod_generator: ^2.4.0
  freezed: ^2.5.0
  custom_lint: ^0.6.0
  riverpod_lint: ^2.3.0
```
