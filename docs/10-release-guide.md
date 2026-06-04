# 10 — Release Guide (Google Play)

Everything needed to turn the validated `.aab` into a Play Store submission.

---

## 1. Current release state ✅

| Item | Status |
|------|--------|
| `flutter build appbundle --release` | ✅ exit 0 — **app-release.aab (58.8 MB)** |
| `targetSdk` | 35 (Play 2025 requirement) |
| `compileSdk` | 36 |
| R8 minify + resource shrink | ✅ enabled |
| ProGuard keep rules | ✅ `android/app/proguard-rules.pro` |
| App icon + adaptive icon + splash | ✅ generated |
| Signing | ⚠️ **debug fallback** until `key.properties` is added |

Artifact: `build/app/outputs/bundle/release/app-release.aab`

---

## 2. Toolchain prerequisites (one-time)

The release build verifies that native libs are stripped using **`apkanalyzer`**,
which lives in **cmdline-tools**. If `flutter build appbundle` fails with
*"Release app bundle failed to strip debug symbols"*, install them:

```bash
# Already done on this machine, kept here for CI / new setups.
SDK="$HOME/Library/Android/sdk"
curl -o /tmp/cmdtools.zip \
  https://dl.google.com/android/repository/commandlinetools-mac-9862592_latest.zip
unzip -q /tmp/cmdtools.zip -d /tmp
mkdir -p "$SDK/cmdline-tools/latest"
cp -R /tmp/cmdline-tools/* "$SDK/cmdline-tools/latest/"
yes | "$SDK/cmdline-tools/latest/bin/sdkmanager" --licenses
```

Pinned `ndkVersion = "28.2.13676358"` in `android/app/build.gradle.kts` so the
strip step resolves the installed NDK.

---

## 3. Create the upload keystore (one-time)

```bash
keytool -genkey -v -keystore ~/cardvault-upload.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Then copy `android/key.properties.template` → `android/key.properties` and fill:

```properties
storePassword=********
keyPassword=********
keyAlias=upload
storeFile=/Users/you/cardvault-upload.jks
```

`key.properties` and `*.jks` are already in `android/.gitignore` — **never commit them**.
With the file present, `buildTypes.release` automatically switches from debug to
the real upload key (see `android/app/build.gradle.kts`).

---

## 4. Build the signed release bundle

```bash
flutter clean
flutter pub get
dart run build_runner build      # regenerate drift code
flutter build appbundle --release
```

Optional, for readable crash reports, also capture Dart symbols:

```bash
flutter build appbundle --release \
  --obfuscate --split-debug-info=build/symbols
```

Upload `app-release.aab` to Play Console. If you obfuscated, upload
`build/symbols` as the native/Dart debug symbols.

---

## 5. Play Console submission order

1. Create app → fill store listing (name, descriptions, graphics).
2. Upload `.aab` to **Internal testing**.
3. Complete **Data safety** ("no data collected / shared") and **Content rating**.
4. Add the **privacy policy URL**.
5. Review the **Pre-launch report**; fix any flagged crash/security items.
6. Promote Internal → Closed → Production (staged rollout recommended).

Work the detailed gates in [07-qa-checklist](07-qa-checklist.md) and
[08-google-play-compliance](08-google-play-compliance.md).

---

## 6. IP reminder (top rejection risk)
The app ships **no franchise art or logos** — the icon is a generic stacked-card
mark. Keep the listing honest: describe game *compatibility* nominatively and
state the app is **unofficial / not affiliated** with any rights holder.
