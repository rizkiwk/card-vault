# 12 — UI/UX Design Prompt (for Claude / design tools)

Paste the block below into Claude (or any UI-generation tool). It is written in
English for best results and is self-contained. Adjust the bracketed notes as
needed.

---

## ✂️ COPY FROM HERE

You are a senior product designer. Design a **modern, simple, clean** mobile
UI/UX for an Android app called **CardVault** — an **offline-first trading-card
collection manager** for Pokémon, One Piece, Yu-Gi-Oh!, Magic: The Gathering and
sports cards. No accounts, no marketplace, no ads — a private, on-device vault.

Deliver high-fidelity screen designs (Material 3 / iOS-friendly), a color system,
typography scale, component specs, and an app icon concept.

### 1. Design principles
- **Simple & clean**: generous whitespace, one primary action per screen, strong
  visual hierarchy, minimal borders (use elevation and soft shadows instead).
- **Content-first**: card photos are the hero — large rounded thumbnails, edge to
  edge grids, low chrome.
- **User-friendly & functional**: thumb-reachable primary actions, clear empty
  states with a single CTA, instant feedback, large tap targets (≥48dp).
- **Accessible**: WCAG AA contrast, dynamic type, semantic labels, works in light
  and dark.

### 2. Color system (current-trend gradient theme)
Use a **vibrant-but-tasteful gradient** brand identity in line with current
trends (electric indigo → violet with a fresh teal accent; soft "mesh gradient"
feel, not neon overload).

- **Primary gradient**: `#4254FF` (electric indigo) → `#7A3DFF` (violet).
  Use diagonally (135°) on the dashboard value card, FAB, and key headers.
- **Accent gradient**: `#00D1B2` (teal) → `#19E3C3` for positive states,
  gains, and highlights.
- **Surfaces**: near-white `#F7F8FC` (light) / deep slate `#0E1116` (dark) with
  layered elevated cards `#FFFFFF` / `#171B22`.
- **Semantic**: success teal-green, loss/negative coral `#FF5A6E`, warning amber.
- Apply gradients **sparingly** — hero surfaces and primary buttons only; keep
  body content on flat neutral surfaces so it stays clean.
- Provide full **light and dark** palettes with exact hex + on-color text colors.

### 3. Typography
- Rounded, friendly geometric sans (e.g. "Plus Jakarta Sans", "Inter", or
  "Manrope"). Bold for numbers/values, regular for body.
- Scale: Display 28–32, Title 18–20, Body 14–16, Caption 12. Tabular figures for
  prices.

### 4. Shape & components
- Corner radius: cards 16–20dp, chips/buttons fully rounded (pill), images 12dp.
- Soft shadows, no hard 1px borders.
- Components to spec: filled gradient button, tonal button, game filter chips,
  tag chips (color-dotted), card grid tile (photo + name + value + qty/condition
  + favorite star), bottom nav bar (4 items + center FAB), modal filter sheet,
  segmented control (Owned/Wishlist), stat cards, bar & donut charts.

### 5. Screens to design (7)
1. **Dashboard** — hero gradient card with total collection value + gain/loss %,
   per-game summary tiles, recently added list, prominent "Add Card" FAB.
2. **Collection** — search bar, horizontal game filter chips, 2-column photo
   grid of card tiles, sort + filter actions, favorites toggle.
3. **Wishlist** — list of desired cards with target price + priority, "Got it!"
   action, friendly empty state.
4. **Add Card** — image capture area (Camera / Gallery), grouped form fields
   (game, name, set, number, rarity, condition, quantity, prices, currency,
   tags), Owned/Wishlist segmented toggle, sticky Save button.
5. **Card Detail** — large hero image (swipe front/back), value vs purchased with
   gain/loss, metadata, tags, notes, edit/delete.
6. **Statistics** — value-by-game bar chart, rarity & condition donut charts,
   top-5 most valuable list, spent-vs-current summary.
7. **Settings** — theme (light/dark/system), default currency, manage tags,
   export/import backup, clear data, about + privacy.

### 6. App icon / brand mark
Design a memorable, **brand-neutral** icon (NO franchise art or logos — legal
requirement). Concept: a **stacked-card "vault" mark** — two or three overlapping
rounded cards fanned slightly, with the front card subtly forming a shield or "V"
(for Vault), filled with the **primary indigo→violet gradient** on a clean
surface. Modern, flat, instantly readable at small sizes. Provide:
- Full-bleed 1024×1024 icon, Android **adaptive** foreground + background,
  monochrome/themed variant, and a horizontal logo lockup with the wordmark
  "CardVault".

### 7. Constraints
- Offline-first: no login, no social, no payment UI anywhere.
- Use only generic placeholder card art in mockups (no real/official cards).
- Show both **light and dark** versions of at least the Dashboard, Collection and
  Card Detail screens.

### Output
Provide: (a) the color tokens (hex, light+dark), (b) type scale, (c) component
sheet, (d) the 7 annotated screens, and (e) the icon + logo lockup. Briefly
explain the key design decisions.

## ✂️ COPY TO HERE

---

## Catatan penggunaan (ID)
- Prompt ini sengaja **berbahasa Inggris** karena tool desain menghasilkan output
  terbaik dengan instruksi Inggris — tapi kamu bisa minta penjelasannya balik
  dalam Bahasa Indonesia.
- Warna gradient **indigo→violet + aksen teal** dipilih agar konsisten dengan
  brand `#3D5AFE` yang sudah dipakai di kode (`AppTheme`), jadi hasil desain
  langsung nyambung dengan implementasi Flutter.
- Konsep icon "stacked-card vault" adalah evolusi dari icon generik yang sudah
  di-generate — tetap **aman IP** (nol art waralaba).
