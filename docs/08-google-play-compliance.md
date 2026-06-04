# 08 — Google Play Compliance Checklist

Target: a clean first submission to the **Google Play Console**. Items marked 🟥 are launch-blocking under current Play policy.

---

## 1. Account & Setup
- [ ] Google Play Developer account active ($25 one-time) 🟥
- [ ] Developer identity verification completed (required for new accounts) 🟥
- [ ] App created in Play Console with unique package `com.cardvault.app` 🟥
- [ ] (New personal accounts) closed testing with 12+ testers for 14 days, if applicable 🟧

## 2. Technical Requirements
- [ ] Targets recent API level (Play requires `targetSdk` ≥ current−1; aim API 34/35) 🟥
- [ ] Builds an **Android App Bundle (.aab)**, not APK 🟥
- [ ] App signing by Google Play enabled 🟥
- [ ] 64-bit native libs included (drift/sqlite3 ship arm64) 🟥
- [ ] Version code & version name set and incremented per release 🟥
- [ ] ProGuard/R8 rules verified (no broken drift/reflection) 🟧
- [ ] App size reasonable; uses bundle splits 🟦

## 3. Permissions Justification
| Permission | Declared? | Justified in listing? |
|-----------|-----------|------------------------|
| CAMERA | [ ] | Capture photos of physical cards 🟥 |
| READ_MEDIA_IMAGES (only if not using Photo Picker) | [ ] | Prefer Android Photo Picker → may need **no** permission 🟥 |
- [ ] No unused/dangerous permissions in manifest 🟥
- [ ] No `QUERY_ALL_PACKAGES`, SMS, location, contacts, etc. 🟥
- [ ] Permissions requested at point-of-use (runtime), not on launch 🟥

## 4. Data Safety Form
- [ ] Completed **Data safety** section in Play Console 🟥
- [ ] Declared: **No data collected**, **No data shared** (offline app) 🟥
- [ ] If any analytics/crash SDK added → declare it accurately 🟥
- [ ] Photos stored **on-device only** — stated, not "collected/transmitted" 🟥
- [ ] Data Safety answers match actual app behavior (audited) 🟥

## 5. Privacy Policy
- [ ] Privacy policy URL provided (hosted, reachable) 🟥
- [ ] States offline-only, no accounts, no data leaves device 🟥
- [ ] Describes camera/photo usage purpose 🟥
- [ ] Linked in-app (Settings → Privacy policy) 🟧

## 6. Content Rating
- [ ] Completed IARC content rating questionnaire 🟥
- [ ] Honest answers (no UGC sharing, no ads, no gambling) 🟥
- [ ] Expected rating: Everyone / PEGI 3 🟧

## 7. Store Listing Assets
- [ ] App name ≤ 30 chars: "CardVault" 🟥
- [ ] Short description ≤ 80 chars 🟥
- [ ] Full description (keywords, no policy-violating claims) 🟥
- [ ] App icon 512×512 PNG 🟥
- [ ] Feature graphic 1024×500 🟥
- [ ] Phone screenshots (min 2, recommend 4–8) 🟥
- [ ] Tablet screenshots (if tablet-supported) 🟧
- [ ] No misleading claims (no "official", no franchise endorsement implied) 🟥

## 8. Intellectual Property ⚠️
- [ ] **No copyrighted card images** bundled in the app 🟥
- [ ] **No trademarked logos** (Pokémon, Yu-Gi-Oh!, etc.) in icon/graphics 🟥
- [ ] Game names used **nominatively** (describing compatibility) only 🟥
- [ ] Listing states app is **unofficial / not affiliated** with rights holders 🟥
- [ ] User-supplied photos remain on-device (no redistribution) 🟥

> IP is the #1 rejection risk for fan/collector apps. Use neutral generic art; never ship official card scans or brand logos.

## 9. Policy Compliance
- [ ] No ads in v1 (if added later: Families policy, ad ID declaration) 🟧
- [ ] No in-app purchases / payments (matches PRD non-goals) 🟥
- [ ] No deceptive behavior, no hidden functionality 🟥
- [ ] Complies with Photo & Video Permissions policy (use Photo Picker) 🟥
- [ ] Foreground service / background location: none 🟥
- [ ] Advertising ID permission NOT declared (no ads/analytics) 🟥
- [ ] Accessibility: no misuse of accessibility APIs 🟦

## 10. Pre-Launch Report
- [ ] Upload to **Internal testing** track first 🟥
- [ ] Review Play Console **Pre-launch report** (crashes, accessibility, security) 🟥
- [ ] Fix flagged crashes / vulnerabilities 🟥
- [ ] Promote Internal → Closed → Production 🟧

## 11. Release Hygiene
- [ ] Release notes written 🟧
- [ ] Staged rollout (e.g. 10% → 50% → 100%) 🟧
- [ ] Crash monitoring plan in place 🟧
- [ ] Support contact email valid 🟥

---

### Final Submission Gate
- [ ] All 🟥 items complete
- [ ] Data Safety ↔ Privacy Policy ↔ actual behavior all consistent
- [ ] IP review passed (no franchise assets shipped)
- [ ] Pre-launch report clean
- [ ] Approver: ______  Date: ______
