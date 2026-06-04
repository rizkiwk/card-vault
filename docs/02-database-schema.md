# 02 — Database Schema (SQLite)

**Engine:** SQLite (via `drift` ORM)
**Mode:** Local, on-device, offline
**Charset:** UTF-8

---

## 1. Entity-Relationship Overview

```
games (1) ─────< (N) cards >───── (N) tags        [via card_tags]
                     │
                     ├──< (N) card_images
                     ├──< (N) price_snapshots
                     └──1 favorite flag / wishlist flag (in cards or separate)

sets (1) ─────< (N) cards
```

* A **card** belongs to one **game** and optionally one **set**.
* A **card** can have many **images** and many **tags** (M:N).
* A **card** can have many **price_snapshots** (value history).
* **Wishlist** is modeled as a `status` column on `cards` (`owned` | `wishlist`) — keeps a single source of truth and lets a wishlist card be promoted to owned in-place.

---

## 2. Tables

### 2.1 `games` (seed/reference data)

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PK, AUTOINCREMENT |
| code | TEXT | UNIQUE, NOT NULL — `pokemon`, `onepiece`, `yugioh`, `mtg`, `sports` |
| name | TEXT | NOT NULL |
| icon_asset | TEXT | NULL |
| sort_order | INTEGER | NOT NULL DEFAULT 0 |

### 2.2 `sets` (card sets / expansions)

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PK, AUTOINCREMENT |
| game_id | INTEGER | FK → games(id) ON DELETE CASCADE |
| name | TEXT | NOT NULL |
| code | TEXT | NULL |
| release_year | INTEGER | NULL |
| total_cards | INTEGER | NULL |

> Sets are user-created on the fly (no online catalog). Free-text allowed.

### 2.3 `cards` (core entity)

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PK, AUTOINCREMENT |
| game_id | INTEGER | FK → games(id), NOT NULL |
| set_id | INTEGER | FK → sets(id) ON DELETE SET NULL, NULL |
| name | TEXT | NOT NULL |
| card_number | TEXT | NULL — e.g. `025/165` |
| rarity | TEXT | NULL — game-specific string |
| condition | TEXT | NOT NULL DEFAULT 'NM' — see enum below |
| quantity | INTEGER | NOT NULL DEFAULT 1, CHECK(quantity >= 0) |
| status | TEXT | NOT NULL DEFAULT 'owned' — `owned` \| `wishlist` |
| is_favorite | INTEGER | NOT NULL DEFAULT 0 (boolean 0/1) |
| purchase_price | REAL | NULL |
| current_value | REAL | NULL |
| currency | TEXT | NOT NULL DEFAULT 'USD' |
| wishlist_priority | INTEGER | NULL — 1=high..3=low |
| wishlist_target_price | REAL | NULL |
| language | TEXT | NULL — e.g. `EN`, `JP` |
| is_graded | INTEGER | NOT NULL DEFAULT 0 |
| grade | TEXT | NULL — e.g. `PSA 10` |
| notes | TEXT | NULL |
| created_at | INTEGER | NOT NULL (epoch ms) |
| updated_at | INTEGER | NOT NULL (epoch ms) |

**Condition enum (stored as TEXT):** `M` (Mint), `NM` (Near Mint), `LP` (Lightly Played), `MP` (Moderately Played), `HP` (Heavily Played), `DMG` (Damaged).

### 2.4 `card_images`

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PK, AUTOINCREMENT |
| card_id | INTEGER | FK → cards(id) ON DELETE CASCADE, NOT NULL |
| file_path | TEXT | NOT NULL — relative path in app dir |
| thumb_path | TEXT | NULL |
| is_primary | INTEGER | NOT NULL DEFAULT 0 |
| side | TEXT | NOT NULL DEFAULT 'front' — `front` \| `back` |
| created_at | INTEGER | NOT NULL |

### 2.5 `tags`

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | TEXT | UNIQUE, NOT NULL |
| color | TEXT | NULL — hex e.g. `#FF5722` |
| created_at | INTEGER | NOT NULL |

### 2.6 `card_tags` (junction M:N)

| Column | Type | Constraints |
|--------|------|-------------|
| card_id | INTEGER | FK → cards(id) ON DELETE CASCADE |
| tag_id | INTEGER | FK → tags(id) ON DELETE CASCADE |
| | | PRIMARY KEY (card_id, tag_id) |

### 2.7 `price_snapshots` (value history — optional/stretch)

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PK, AUTOINCREMENT |
| card_id | INTEGER | FK → cards(id) ON DELETE CASCADE |
| value | REAL | NOT NULL |
| currency | TEXT | NOT NULL |
| recorded_at | INTEGER | NOT NULL |

### 2.8 `app_settings` (key-value)

| Column | Type | Constraints |
|--------|------|-------------|
| key | TEXT | PK |
| value | TEXT | NOT NULL |

---

## 3. Indexes

```sql
CREATE INDEX idx_cards_game        ON cards(game_id);
CREATE INDEX idx_cards_set         ON cards(set_id);
CREATE INDEX idx_cards_status      ON cards(status);
CREATE INDEX idx_cards_favorite    ON cards(is_favorite);
CREATE INDEX idx_cards_name        ON cards(name COLLATE NOCASE);
CREATE INDEX idx_cardimages_card   ON card_images(card_id);
CREATE INDEX idx_cardtags_tag      ON card_tags(tag_id);
CREATE INDEX idx_snapshots_card    ON price_snapshots(card_id, recorded_at);
```

**Full-text search (optional):** an FTS5 virtual table mirroring `cards(name, card_number, notes)` for sub-200ms search at scale.

```sql
CREATE VIRTUAL TABLE cards_fts USING fts5(
  name, card_number, notes, content='cards', content_rowid='id'
);
```

---

## 4. DDL (Reference — `cards` + `card_tags`)

```sql
CREATE TABLE cards (
  id                    INTEGER PRIMARY KEY AUTOINCREMENT,
  game_id               INTEGER NOT NULL REFERENCES games(id),
  set_id                INTEGER REFERENCES sets(id) ON DELETE SET NULL,
  name                  TEXT    NOT NULL,
  card_number           TEXT,
  rarity                TEXT,
  condition             TEXT    NOT NULL DEFAULT 'NM',
  quantity              INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 0),
  status                TEXT    NOT NULL DEFAULT 'owned',
  is_favorite           INTEGER NOT NULL DEFAULT 0,
  purchase_price        REAL,
  current_value         REAL,
  currency              TEXT    NOT NULL DEFAULT 'USD',
  wishlist_priority     INTEGER,
  wishlist_target_price REAL,
  language              TEXT,
  is_graded             INTEGER NOT NULL DEFAULT 0,
  grade                 TEXT,
  notes                 TEXT,
  created_at            INTEGER NOT NULL,
  updated_at            INTEGER NOT NULL
);

CREATE TABLE card_tags (
  card_id INTEGER NOT NULL REFERENCES cards(id) ON DELETE CASCADE,
  tag_id  INTEGER NOT NULL REFERENCES tags(id)  ON DELETE CASCADE,
  PRIMARY KEY (card_id, tag_id)
);
```

---

## 5. Key Queries

```sql
-- Total collection value
SELECT SUM(current_value * quantity) AS total_value
FROM cards WHERE status = 'owned';

-- Gain / loss
SELECT SUM(current_value * quantity) - SUM(purchase_price * quantity) AS pnl
FROM cards WHERE status = 'owned';

-- Cards per game
SELECT g.name, COUNT(c.id) AS cnt, SUM(c.quantity) AS copies
FROM cards c JOIN games g ON g.id = c.game_id
WHERE c.status = 'owned'
GROUP BY g.id ORDER BY cnt DESC;

-- Top 5 most valuable
SELECT name, current_value FROM cards
WHERE status = 'owned' ORDER BY current_value DESC LIMIT 5;
```

---

## 6. Migration Strategy

* Use `drift`'s `schemaVersion` + `MigrationStrategy`.
* `onCreate`: build tables + seed `games` (5 rows) + default tags.
* `onUpgrade`: stepwise migrations (v1→v2…), never drop user data.
* Schema versions tracked in `lib/core/database/schema_versions/`.
* Foreign keys enforced: `PRAGMA foreign_keys = ON;` on every open.

---

## 7. Seed Data (`games`)

| code | name | sort_order |
|------|------|-----------|
| pokemon | Pokémon | 1 |
| onepiece | One Piece | 2 |
| yugioh | Yu-Gi-Oh! | 3 |
| mtg | Magic: The Gathering | 4 |
| sports | Sports Cards | 5 |
