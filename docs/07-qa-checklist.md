# 07 — QA Checklist

Use as a pre-release gate. Mark each `[ ]` → `[x]`. A release is blocked on any failing 🟥 item.

---

## 1. Collection Management
- [ ] Add card with all fields populated saves correctly 🟥
- [ ] Add card with only required fields (name, game, condition) saves 🟥
- [ ] Edit card persists changes and updates lists 🟥
- [ ] Delete card removes row **and** orphaned image files 🟥
- [ ] Quantity increment/decrement works; cannot go below 0 🟥
- [ ] Card appears under correct game chip/filter 🟥
- [ ] Duplicate-looking cards (same name) stored independently 🟧

## 2. Add Card / Validation
- [ ] Saving without required field shows inline error, blocks save 🟥
- [ ] Negative/invalid price rejected 🟥
- [ ] Very long name/notes handled (no overflow/crash) 🟧
- [ ] New set typed inline is created & reusable 🟧
- [ ] Owned ↔ Wishlist status toggle on create works 🟥

## 3. Images (Camera & Gallery)
- [ ] Camera capture stores compressed image 🟥
- [ ] Gallery pick stores image 🟥
- [ ] Camera permission denied → graceful message, no crash 🟥
- [ ] Photo permission denied → graceful fallback 🟥
- [ ] Front + back images both viewable in detail (swipe) 🟧
- [ ] Thumbnails render in list without jank 🟥
- [ ] Large image (e.g. 12MP) compresses, doesn't OOM 🟥

## 4. Wishlist
- [ ] Add wishlist card appears only in Wishlist, not Collection 🟥
- [ ] "Got it!" promotes card to owned, removes from wishlist 🟥
- [ ] Target price & priority saved and displayed 🟧
- [ ] Empty wishlist shows empty state 🟧

## 5. Favorites
- [ ] Toggling ★ persists across app restart 🟥
- [ ] Favorites-only filter shows correct subset 🟥

## 6. Tags
- [ ] Create/rename/delete tag works 🟥
- [ ] Deleting a tag removes it from all cards (no dangling) 🟥
- [ ] Assign multiple tags to one card 🟥
- [ ] Filter by tag returns correct cards 🟥
- [ ] Tag color renders correctly 🟦

## 7. Search & Filters
- [ ] Search by name returns matches 🟥
- [ ] Search by card number / notes returns matches 🟧
- [ ] Combined filters (game + condition + value range) intersect correctly 🟥
- [ ] Reset filters restores full list 🟥
- [ ] Sort options reorder correctly 🟧
- [ ] Search on 5,000-card DB returns < 200ms 🟥

## 8. Statistics & Value
- [ ] Total value = Σ(current_value × quantity) for owned only 🟥
- [ ] P/L = current − purchase, sign correct 🟥
- [ ] Per-game counts match collection 🟥
- [ ] Charts render with 0, 1, and many data points 🟥
- [ ] Cards with null value excluded gracefully (no NaN) 🟥
- [ ] Currency formatting matches settings 🟧

## 9. Dashboard
- [ ] Totals match Statistics screen 🟥
- [ ] Recently added shows newest first 🟧
- [ ] Quick actions navigate correctly 🟧

## 10. Settings & Data
- [ ] Theme switch (light/dark/system) applies immediately & persists 🟥
- [ ] Currency change reflects across app 🟧
- [ ] Export produces valid JSON + image archive 🟧
- [ ] Import restores collection accurately 🟧
- [ ] Clear-all-data wipes DB + images after confirmation 🟥
- [ ] Cancel on destructive dialog aborts safely 🟥

## 11. Offline / Data Integrity
- [ ] All features work in Airplane Mode 🟥
- [ ] No network calls observed (verify with proxy/inspector) 🟥
- [ ] App restart preserves all data 🟥
- [ ] Force-kill mid-edit does not corrupt DB 🟥
- [ ] DB migration from v1→v2 keeps data (simulate) 🟥

## 12. Performance & Stability
- [ ] Cold start < 2s (mid-tier device) 🟥
- [ ] Scroll 5,000 cards at ~60fps 🟥
- [ ] No memory leak after navigating all screens repeatedly 🟧
- [ ] Crash-free across full smoke test 🟥

## 13. UI / UX / Accessibility
- [ ] Layout correct on small (5") and large (tablet) screens 🟧
- [ ] Dark mode contrast acceptable 🟧
- [ ] Text scaling 200% does not clip critical controls 🟧
- [ ] All interactive elements have semantics labels 🟧
- [ ] Empty states present on Collection/Wishlist/Stats 🟧
- [ ] Back button / gesture behaves on every screen 🟥

## 14. Permissions Lifecycle
- [ ] First-use camera prompt appears at right moment 🟥
- [ ] "Don't ask again" path routes user to settings 🟥
- [ ] App functions (minus photos) if all media perms denied 🟥

## 15. Device Matrix (run smoke test on each)
| Device class | Android | Result |
|--------------|---------|--------|
| Low-end (2GB RAM) | 8.0 / API 26 | [ ] |
| Mid-tier | 12 / API 31 | [ ] |
| Latest | 14+ / API 34+ | [ ] |
| Tablet | 13 | [ ] |

---

### Sign-off
- [ ] All 🟥 items pass
- [ ] No open Sev-1/Sev-2 bugs
- [ ] QA lead approval: ______  Date: ______
