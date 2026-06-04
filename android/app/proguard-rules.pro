# Flutter wrapper — keep embedding entry points.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.embedding.** { *; }

# sqlite3 / drift native bindings (sqlite3_flutter_libs loads native code).
-keep class com.tekartik.** { *; }
-dontwarn org.sqlite.**

# Play Core (used by Flutter's deferred components shim). Avoid R8 stripping
# warnings when the library isn't bundled.
-dontwarn com.google.android.play.core.**

# Keep annotations and generic signatures (drift generated companions).
-keepattributes *Annotation*, Signature, InnerClasses, EnclosingMethod
