# 06 — Roadmap

**Strategy:** Ship a usable offline core fast (MVP), then layer organization, insight, and polish. Phases are sequential but features within a phase can parallelize.

Legend: 🟥 Must · 🟧 Should · 🟦 Could

---

## Phase 0 — Foundation (Week 1)
| Item | Priority |
|------|----------|
| Flutter project scaffold + folder structure | 🟥 |
| Add dependencies (riverpod, drift, go_router, image_picker) | 🟥 |
| drift database + tables + seed `games` | 🟥 |
| App theme (Material 3, light/dark) + router shell | 🟥 |
| CI: format + analyze + test on PR | 🟧 |

**Exit criteria:** app launches, empty bottom-nav shell navigates, DB opens & seeds.

---

## Phase 1 — Core Collection MVP (Weeks 2–3)
| Item | Priority |
|------|----------|
| Domain: Card entity, repository interface, usecases | 🟥 |
| Data: CardModel, local datasource, repository impl | 🟥 |
| Add Card screen (manual entry, all fields) | 🟥 |
| Image capture (Camera + Gallery) + storage service | 🟥 |
| Collection screen (grid/list, game chips) | 🟥 |
| Card Detail screen (view/edit/delete) | 🟥 |
| Quantity & condition handling | 🟥 |

**Exit criteria:** user can add a card with a photo, see it in Collection, open detail, edit, delete — fully offline.

---

## Phase 2 — Organization (Week 4)
| Item | Priority |
|------|----------|
| Favorites toggle + filter | 🟥 |
| Wishlist (status field, screen, "Got it!" promote) | 🟥 |
| Tags (CRUD, color, M:N, assign on card) | 🟥 |
| Search (name/number/notes) | 🟥 |
| Filters (game, set, rarity, condition, tags, value range) | 🟥 |
| Sort (value, name, date, quantity) | 🟧 |

**Exit criteria:** a 500-card collection is searchable and filterable in < 200ms.

---

## Phase 3 — Insight & Value (Week 5)
| Item | Priority |
|------|----------|
| Dashboard (total value, per-game, recent) | 🟥 |
| Collection value tracking (sum, P/L) | 🟥 |
| Statistics screen (charts: by game/rarity/condition) | 🟥 |
| Top N most valuable | 🟧 |
| Price snapshots / value history | 🟦 |

**Exit criteria:** dashboard & stats reflect real aggregates accurately.

---

## Phase 4 — Settings & Data Safety (Week 6)
| Item | Priority |
|------|----------|
| Settings (theme, currency, about, licenses) | 🟥 |
| Tags & sets management screens | 🟧 |
| Export collection (JSON + image zip) | 🟧 |
| Import collection | 🟧 |
| Clear-all-data with confirmation | 🟥 |

**Exit criteria:** user can back up and restore their entire vault.

---

## Phase 5 — Polish & Release (Weeks 7–8)
| Item | Priority |
|------|----------|
| Empty states, loading skeletons, error handling | 🟥 |
| Accessibility (text scaling, contrast, semantics) | 🟥 |
| Performance pass (5k cards, lazy thumbnails) | 🟥 |
| App icon, splash, store screenshots | 🟥 |
| Privacy policy + Play Data Safety form | 🟥 |
| QA full pass (see QA checklist) | 🟥 |
| Internal testing track → closed → production | 🟥 |
| Localization scaffolding (ARB, EN) | 🟦 |

**Exit criteria:** Play Store listing approved, crash-free ≥ 99.5% in internal track.

---

## Post-1.0 Backlog (Future)
* iOS release.
* CSV import/export.
* Barcode/set-symbol assisted entry (still offline, on-device ML).
* Multiple collection profiles.
* Optional encrypted local backup.
* Bulk edit & batch tagging.

---

## Milestone Summary

| Milestone | Target | Definition of Done |
|-----------|--------|--------------------|
| **M1 – Walking Skeleton** | End W1 | Shell + DB |
| **M2 – Collection MVP** | End W3 | Add/view/edit/delete with photos |
| **M3 – Organized** | End W4 | Search, filter, tags, wishlist, favorites |
| **M4 – Insightful** | End W5 | Dashboard + stats + value |
| **M5 – Release Candidate** | End W7 | Settings, backup, QA green |
| **M6 – Live** | End W8 | Published to Google Play |
