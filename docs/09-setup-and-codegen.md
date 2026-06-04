# 09 — Setup & Code Generation

This repo contains the **Phase 0–1 boilerplate** for CardVault. Because `drift`
relies on code generation, you must run `build_runner` before the app compiles.

---

## 1. Prerequisites
* Flutter SDK ≥ 3.4 (`flutter --version`)
* Android Studio / Xcode toolchains for device builds

## 2. First-time setup

```bash
cd card_vault

# 1. Generate the Android/iOS platform folders if missing
#    (the lib/ + docs/ are already provided).
flutter create --org com.cardvault --platforms=android,ios .

# 2. Fetch dependencies
flutter pub get

# 3. Generate drift code (creates lib/core/database/app_database.g.dart)
dart run build_runner build --delete-conflicting-outputs

# 4. Run
flutter run
```

> ⚠️ Until step 3 runs, `app_database.g.dart` does not exist and you will see
> "part 'app_database.g.dart' not found" — this is expected.

## 3. Watch mode (during development)

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## 4. Tests

```bash
flutter test
```

`test/card_repository_test.dart` uses an in-memory drift DB — no device needed.

---

## 5. What's implemented (Phase 0–4) — ✅ analyze clean, 13 tests passing

| Area | Status |
|------|--------|
| drift DB + 7 tables (incl. `app_settings`) + seed games | ✅ |
| Card entity / repository / usecases | ✅ |
| Add Card (manual + camera/gallery + tags + currency) | ✅ |
| Collection (grid, search, game chips, favorites) | ✅ |
| Card Detail (view / edit / delete + image cleanup) | ✅ |
| Wishlist (list + "Got it!") | ✅ |
| Tags CRUD + assign on card (`card_tags`) | ✅ Phase 2 |
| Filter sheet + sort menu | ✅ Phase 2 |
| Dashboard value + gain/loss % | ✅ Phase 3 |
| Statistics: value-by-game bar, rarity & condition pies, top-5 | ✅ Phase 3 |
| **Settings: theme (light/dark/system) persisted** | ✅ Phase 4 |
| **Default currency persisted + applied to new cards** | ✅ Phase 4 |
| **Export / Import `.cardvault` backup (zip: JSON + images)** | ✅ Phase 4 |
| **Clear-all-data with confirmation** | ✅ Phase 4 |
| Image compression / thumbnails | ⬜ Phase 5 |

## 6. Engineering decisions (Phase 4)
* **Schema v2 migration**: added `app_settings` (key-value) via `onUpgrade`
  `createTable`; existing data preserved.
* **Removed `drift_flutter`**: it pinned an incompatible drift API. The DB now
  opens via a `LazyDatabase` + `NativeDatabase.createInBackground` directly.
* **Explicit referential cleanup**: drift's generated DDL did not emit FK
  constraints, so deletes cascade is handled in the data layer inside
  transactions (`deleteCard`, tag `delete`, `clearAllData`).

## 7. Phase 5 — Polish & Release ✅ (analyze clean · 15 tests · APK builds)

| Item | Status |
|------|--------|
| Real image compression + 256px thumbnails (background isolate) | ✅ |
| Tag & game filtering pushed into SQL (subqueries) | ✅ |
| Accessibility: semantic labels on card tiles | ✅ |
| App icon + adaptive icon + native splash (generated) | ✅ |
| **`flutter build apk --debug` succeeds** | ✅ |

### Build configuration notes
* **`compileSdk = 36`** in `android/app/build.gradle.kts`; a `subprojects`
  override in `android/build.gradle.kts` forces all plugin modules to 36
  (file_picker still pins 34, which conflicts with newer transitive deps).
* App icon is generated programmatically by `tool/gen_icon.dart` (brand-neutral,
  no franchise art) → `assets/icon/`, then `flutter_launcher_icons` +
  `flutter_native_splash`.
* `image` package handles compression/thumbnailing off the UI isolate via
  `compute`.

### Remaining before Play submission (manual)
1. **Bump `targetSdk` to 35** (Google Play 2025 requirement) — currently inherits
   Flutter default.
2. Add a real release **signing config** + build an **app bundle**
   (`flutter build appbundle --release`).
3. Produce store screenshots, feature graphic, privacy policy URL.
4. Complete the Data Safety form ("no data collected/shared").
5. Work through [07-qa-checklist](07-qa-checklist.md) and
   [08-google-play-compliance](08-google-play-compliance.md).
