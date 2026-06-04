# 04 — UI Wireframes (ASCII)

Low-fidelity wireframes for all **7 screens**. Bottom navigation hosts the 4 primary destinations; Add Card is a center FAB; Card Detail and Statistics are pushed routes.

**Bottom Nav:** `[ Dashboard ] [ Collection ] (＋) [ Wishlist ] [ Settings ]`

---

## 1. Dashboard

```
┌─────────────────────────────────────┐
│  CardVault              🔔   ⚙️       │
├─────────────────────────────────────┤
│  ┌───────────────────────────────┐  │
│  │  Total Collection Value       │  │
│  │  $ 12,480.50      ▲ +4.2%     │  │
│  │  1,204 cards · 318 unique     │  │
│  └───────────────────────────────┘  │
│                                     │
│  Quick Actions                      │
│  [ ＋ Add Card ] [ ★ Favorites ]    │
│  [ 🔍 Search   ] [ 📊 Stats     ]   │
│                                     │
│  By Game                            │
│  ┌──────┐┌──────┐┌──────┐┌──────┐  │
│  │Poké  ││ OP   ││YuGiOh││ MTG  │  │
│  │ 540  ││ 210  ││ 180  ││ 224  │  │
│  └──────┘└──────┘└──────┘└──────┘  │
│                                     │
│  Recently Added            See all >│
│  ┌────┐ Charizard VMAX   $320       │
│  │IMG │ Pokémon · SWSH · NM         │
│  └────┘                             │
├─────────────────────────────────────┤
│ 🏠   📚    (＋)    ❤️     ⚙️         │
└─────────────────────────────────────┘
```

---

## 2. Collection

```
┌─────────────────────────────────────┐
│  Collection            🔍   ⋮ filter │
├─────────────────────────────────────┤
│  [All] [Poké] [OP] [YGO] [MTG] [Spt] │  ← game chips
│  Sort: Value ▾      ★ Favorites only │
├─────────────────────────────────────┤
│  ┌────────┐  ┌────────┐  ┌────────┐ │
│  │  IMG   │  │  IMG   │  │  IMG   │ │
│  │        │  │        │  │  ★     │ │
│  │Charizrd│  │ Pikachu│  │ Luffy  │ │
│  │ $320   │  │  $45   │  │  $90   │ │
│  │ x2 NM  │  │ x1 LP  │  │ x1 M   │ │
│  └────────┘  └────────┘  └────────┘ │
│  ┌────────┐  ┌────────┐  ┌────────┐ │
│  │  ...   │  │  ...   │  │  ...   │ │
│  └────────┘  └────────┘  └────────┘ │
│                                     │
│           (grid / list toggle)      │
├─────────────────────────────────────┤
│ 🏠   📚    (＋)    ❤️     ⚙️         │
└─────────────────────────────────────┘

  Filter Sheet (slides up):
  ┌─────────────────────────────────┐
  │ Filters                  Reset   │
  │ Game     [▾ All]                 │
  │ Set      [▾ Any]                 │
  │ Rarity   [▾ Any]                 │
  │ Condition[ M NM LP MP HP DMG ]   │
  │ Tags     [#vintage] [#graded] +  │
  │ Value    $[___]  –  $[___]       │
  │           [ Apply Filters ]      │
  └─────────────────────────────────┘
```

---

## 3. Wishlist

```
┌─────────────────────────────────────┐
│  Wishlist               🔍   ＋       │
├─────────────────────────────────────┤
│  Target total: $ 1,850              │
├─────────────────────────────────────┤
│  ┌────┐ Black Lotus      🔴 High    │
│  │IMG │ MTG · Alpha                 │
│  │    │ Target: $8,000   [ Got it! ]│
│  └────┘                             │
│  ┌────┐ Lugia 1st Ed     🟡 Med     │
│  │IMG │ Pokémon · Neo               │
│  │    │ Target: $400     [ Got it! ]│
│  └────┘                             │
│                                     │
│  (empty state)                      │
│        ✨ Nothing on your wishlist  │
│        Tap ＋ to add a dream card   │
├─────────────────────────────────────┤
│ 🏠   📚    (＋)    ❤️     ⚙️         │
└─────────────────────────────────────┘
```

---

## 4. Add Card

```
┌─────────────────────────────────────┐
│  ✕   Add Card               Save    │
├─────────────────────────────────────┤
│  ┌─────────────┐                    │
│  │   📷 + 🖼️    │  Tap to add photo  │
│  │  Front | Back│  (Camera/Gallery)  │
│  └─────────────┘                    │
│                                     │
│  Game *      [▾ Pokémon         ]   │
│  Card Name * [_________________]    │
│  Set         [▾ or type new     ]   │
│  Card No.    [025/165          ]    │
│  Rarity      [▾ Secret Rare    ]    │
│  Condition * [ M NM• LP MP HP DMG]  │
│  Quantity    [ − ] 1 [ + ]          │
│                                     │
│  Purchase $  [____]  Value $ [____] │
│  Currency    [▾ USD]                │
│  Language    [▾ EN]   Graded [ ]    │
│                                     │
│  Tags        [#vintage] [ + add ]   │
│  Notes       [________________]     │
│                                     │
│  Status:  ( • Owned )  ( ○ Wishlist)│
│                                     │
│         [    Save Card    ]         │
└─────────────────────────────────────┘
```

---

## 5. Card Detail

```
┌─────────────────────────────────────┐
│  ←   Charizard VMAX     ★   ✏️   ⋮   │
├─────────────────────────────────────┤
│        ┌───────────────┐            │
│        │               │            │
│        │   CARD IMAGE  │  ‹ front › │
│        │   (swipe)     │            │
│        └───────────────┘            │
│        ● ○   front / back           │
├─────────────────────────────────────┤
│  Pokémon · SWSH · #074/073          │
│  Secret Rare · NM · EN · x2         │
│                                     │
│  ┌─────────────┐ ┌─────────────┐    │
│  │ Current     │ │ Purchased   │    │
│  │ $320.00     │ │ $180.00     │    │
│  └─────────────┘ └─────────────┘    │
│  Gain: ▲ +$140.00 (+77%)            │
│                                     │
│  Tags:  #grail  #graded             │
│  Notes: Pulled from booster, 2021.  │
│                                     │
│  [ Edit ]      [ 🗑 Delete ]        │
└─────────────────────────────────────┘
```

---

## 6. Statistics

```
┌─────────────────────────────────────┐
│  ←   Statistics                     │
├─────────────────────────────────────┤
│  Overview                           │
│  Total value  $12,480   P/L ▲+$2,1k │
│  Cards 1,204 · Unique 318 · Sets 27 │
│                                     │
│  Value by Game        (bar chart)   │
│   Poké ████████████ $5.4k           │
│   MTG  ████████ $3.9k                │
│   OP   ████ $1.6k                    │
│   YGO  ███ $1.0k                     │
│   Spt  █ $0.5k                       │
│                                     │
│  By Rarity            (pie chart)   │
│      ◔ Common 40% · Rare 35% ...    │
│                                     │
│  By Condition                       │
│   NM ██████ · LP ███ · M ██ ...     │
│                                     │
│  Top 5 Most Valuable                │
│  1. Black Lotus        $8,000       │
│  2. Charizard VMAX     $320         │
│  ...                                │
└─────────────────────────────────────┘
```

---

## 7. Settings

```
┌─────────────────────────────────────┐
│  Settings                           │
├─────────────────────────────────────┤
│  APPEARANCE                          │
│   Theme            [ System ▾ ]     │
│   Default currency [ USD ▾ ]        │
│                                     │
│  ORGANIZATION                        │
│   Manage tags                  >    │
│   Manage sets                  >    │
│                                     │
│  DATA                                │
│   Export collection (JSON+zip) >    │
│   Import collection            >    │
│   Clear all data               >    │
│                                     │
│  PERMISSIONS                         │
│   Camera           [ Granted ]      │
│   Photos           [ Granted ]      │
│                                     │
│  ABOUT                               │
│   Version 1.0.0                     │
│   Privacy policy               >    │
│   Open-source licenses         >    │
├─────────────────────────────────────┤
│ 🏠   📚    (＋)    ❤️     ⚙️         │
└─────────────────────────────────────┘
```

---

## Design Notes
* **Material 3** components, dynamic color where available.
* Card tiles use cached thumbnails for scroll performance.
* Empty states everywhere (Collection, Wishlist, Stats) with a friendly CTA.
* All destructive actions (delete, clear data) require confirmation dialog.
