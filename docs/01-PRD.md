# 01 — Product Requirements Document (PRD)

**Product:** CardVault
**Version:** 1.0
**Platform:** Android (primary), iOS-ready (Flutter)
**Mode:** 100% Offline
**Date:** 2026-06-04

---

## 1. Vision

CardVault is a **private, offline-first** mobile app that lets trading-card collectors catalog, value, and organize their physical collections across five franchises — **Pokémon, One Piece, Yu-Gi-Oh!, Magic: The Gathering (MTG), and Sports cards** — without ever needing an account or an internet connection.

**One-line pitch:** *Your shoebox of cards, but searchable, valued, and backed up.*

---

## 2. Goals & Non-Goals

### 2.1 Goals
* Fast manual entry of cards with photos.
* Track collection **value** and **statistics** over time.
* Organize via **tags, favorites, wishlist, search & filters**.
* Work **fully offline** — all data on-device.
* Respect user **privacy** (no telemetry by default, no accounts).

### 2.2 Non-Goals (Explicitly Out of Scope)
| ❌ Excluded | Reason |
|------------|--------|
| Marketplace / buying / selling | Out of product scope |
| User accounts / cloud login | Offline-first, privacy-first |
| Payments / in-app purchases | No monetization in v1 |
| Chat / social / messaging | Not a social product |
| Real-time price API | Manual value entry only (offline) |

---

## 3. Target Personas

| Persona | Description | Key Need |
|---------|-------------|----------|
| **The Casual Collector** | Owns 50–300 cards, multiple games | Quick logging, "what do I own?" |
| **The Value Tracker** | Treats cards as assets | Total value, per-card price tracking |
| **The Completionist** | Chasing full sets | Wishlist + set/progress filters |
| **The Multi-Game Hobbyist** | Plays Pokémon + MTG + One Piece | Cross-game organization & tags |

---

## 4. Functional Requirements

### FR-1 Collection Management
* CRUD cards (create, read, update, delete).
* Group/filter by **game**, **set**, **rarity**, **condition**, **tags**.
* Quantity per card (own multiple copies).

### FR-2 Add Card Manually
* Form fields: name, game, set, card number, rarity, condition, quantity, purchase price, current value, notes, tags.
* Game selector drives game-specific fields (e.g., MTG mana color, Pokémon HP — optional metadata).
* Inline validation; save as draft if incomplete (optional stretch).

### FR-3 Card Image Storage
* Capture via **Camera** or pick from **Gallery**.
* Store image file in **app-private storage**; DB holds the relative path.
* Support front + back image (back optional).
* Thumbnails generated for list performance.

### FR-4 Wishlist
* Mark desired cards (not yet owned).
* Optional target price + priority.
* "Move to collection" action when acquired.

### FR-5 Favorites
* Toggle ⭐ on any owned card.
* Dedicated favorites filter on Collection screen.

### FR-6 Collection Statistics
* Total cards, unique cards, cards per game.
* Distribution by rarity, condition, set.
* Top N most valuable cards.
* Charts (bar/pie).

### FR-7 Collection Value Tracking
* Sum of `current_value × quantity`.
* Total spent (sum of purchase prices) vs. current value → gain/loss.
* Per-card value history (snapshot on edit) for trend (stretch).

### FR-8 Tags
* Free-form, user-defined, color-coded tags.
* Many-to-many: a card can have multiple tags.
* Filter & manage tags from Settings.

### FR-9 Search & Filters
* Full-text search on name / set / number / notes.
* Composable filters: game, set, rarity, condition, tags, favorite, value range.
* Sort: name, value, date added, quantity.

---

## 5. Non-Functional Requirements

| Category | Requirement |
|----------|-------------|
| **Performance** | List of 5,000 cards scrolls at 60fps; search < 200ms |
| **Offline** | Zero network calls required for any core feature |
| **Storage** | Images compressed (≤ 1MB each), DB indexed |
| **Privacy** | No analytics SDK by default; opt-in only |
| **Accessibility** | Dynamic text scaling, contrast ≥ WCAG AA, semantics labels |
| **Localization** | i18n-ready (EN first; ID/others via ARB) |
| **Backup** | Manual export/import (JSON + image zip) — stretch v1.1 |
| **Theming** | Light / Dark / System |

---

## 6. Screens (7)

1. **Dashboard** — summary cards, total value, quick actions.
2. **Collection** — grid/list of owned cards + search/filters.
3. **Wishlist** — desired cards.
4. **Add Card** — manual entry form + image capture.
5. **Card Detail** — full card view, edit/delete, value, tags.
6. **Statistics** — charts & breakdowns.
7. **Settings** — theme, tags manager, backup, permissions, about.

See [UI Wireframes](04-ui-wireframes.md).

---

## 7. Permissions

| Permission | Usage | Trigger |
|-----------|-------|---------|
| `CAMERA` | Capture card photos | When user taps "Take Photo" |
| Gallery (Photo Picker) | Select existing images | When user taps "From Gallery" |

> Android 13+ uses the **Photo Picker** (`READ_MEDIA_IMAGES` only if legacy access needed). Camera permission requested at point-of-use (runtime).

---

## 8. Success Metrics (Internal)

* Time to add a card < 30s.
* Crash-free sessions ≥ 99.5%.
* Cold start < 2s on mid-tier device.
* DB query (filtered list) < 150ms at 2k cards.

---

## 9. Assumptions & Constraints

* All prices entered **manually** by the user (currency configurable in Settings).
* No server component; backups are local files the user controls.
* Single-user, single-device (multi-device sync is out of scope).
