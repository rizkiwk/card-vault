# CardVault 🃏

> Offline-first card collection manager for **Pokémon**, **One Piece**, **Yu-Gi-Oh!**, **Magic: The Gathering**, and **Sports** cards.

CardVault is a Flutter application built with **Clean Architecture**, **Riverpod**, and the **Repository Pattern**, backed by a local **SQLite** database. No accounts, no marketplace, no payments — just a fast, private, fully-offline vault for collectors.

---

## 📚 Documentation Index

| # | Document | Description |
|---|----------|-------------|
| 01 | [Product Requirements (PRD)](docs/01-PRD.md) | Vision, personas, scope, functional & non-functional requirements |
| 02 | [Database Schema](docs/02-database-schema.md) | SQLite tables, relations, indexes, migrations |
| 03 | [Folder Structure](docs/03-folder-structure.md) | Clean Architecture project layout |
| 04 | [UI Wireframes](docs/04-ui-wireframes.md) | ASCII wireframes for all 7 screens |
| 05 | [Flutter Architecture](docs/05-architecture.md) | Layers, Riverpod providers, data flow |
| 06 | [Roadmap](docs/06-roadmap.md) | Phased delivery plan & milestones |
| 07 | [QA Checklist](docs/07-qa-checklist.md) | Functional, edge-case & device test matrix |
| 08 | [Google Play Compliance](docs/08-google-play-compliance.md) | Store listing, policy & release checklist |

---

## 🚀 Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart 3.x) |
| State Management | Riverpod 2.x (code-gen) |
| Local DB | SQLite via `drift` |
| Image Capture | `image_picker` + `camera` |
| Local Storage | App-private file dir + `path_provider` |
| Architecture | Clean Architecture + Repository Pattern |

---

## ⚡ Quick Start (once Flutter is installed)

```bash
flutter create --org com.cardvault --platforms=android,ios card_vault
cd card_vault
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

> *Kukuku… 10 billion percent ready to build.* — Kingdom of Science Core
