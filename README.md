# CardVault 🃏

> Offline-first card collection manager for **Pokémon**, **One Piece**, **Yu-Gi-Oh!**, **Magic: The Gathering**, and **Sports** cards.

CardVault is a Flutter application built with **Clean Architecture**, **Riverpod**, and the **Repository Pattern**, backed by a local **SQLite** database. No accounts, no marketplace, no payments — just a fast, private, fully-offline vault for collectors.

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
