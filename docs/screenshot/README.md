# CardVault — Play Store Screenshots

Phone screenshots captured live from the running app (gradient design direction)
on an Android emulator (Pixel-class, 1080×2400), then cropped to **1080×2160**
(exactly **2:1**, Google Play's maximum allowed aspect ratio).

## Files (upload these)

| # | File | Screen | Highlights |
|---|------|--------|-----------|
| 1 | `1-dashboard.png` | Dashboard | Gradient value hero `$10,420` · +26.8% · per-game |
| 2 | `2-collection.png` | Collection | Photo grid, favorite/condition badges, value + qty |
| 3 | `3-card-detail.png` | Card Detail | Value vs purchased, gain/loss, tags, notes |
| 4 | `4-statistics.png` | Statistics | Value-by-game bars, rarity donut, gain/loss |
| 5 | `5-wishlist.png` | Wishlist | Target total, priority dots, "Got it!" |

`raw/` holds the original full-resolution captures (1080×2400) for reference.

## Play Console requirements (met)
- Format: 24-bit PNG ✓
- Dimensions: 1080×2160, within 320–3840 px ✓
- Aspect ratio ≤ 2:1 ✓ (these are exactly 2:1)
- 2–8 phone screenshots required → 5 provided ✓

## Notes
- The data shown is sample/seed content for marketing; real users see their own
  cards. Card images are custom abstract, IP-safe generative artwork — **no
  franchise art** — consistent with the Play Store listing guidance.
- `card-art/` contains the generated source card images used in Collection,
  Card Detail, and Wishlist screenshots.
- To regenerate after new captures: drop fresh `1080×2400` PNGs at the
  `/tmp/cv_*_full.png` paths and run `dart run tool/crop_shots.dart`.
- To regenerate the card artwork overlays, run
  `dart run tool/update_screenshot_card_art.dart`.
- Recommended upload order matches the numbering (Dashboard first as the hero).
