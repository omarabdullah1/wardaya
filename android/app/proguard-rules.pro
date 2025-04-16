# Keep classes referenced by OkHttp
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes SourceFile, LineNumberTable
-keep public class * extends java.lang.Exception

# Keep OkHttp and its dependencies
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**

# Keep specifically the classes mentioned in the error
-keep class org.bouncycastle.jsse.** { *; }
-keep class org.bouncycastle.jsse.provider.** { *; }
-keep class org.conscrypt.** { *; }
-keep class org.openjsse.** { *; }

# Keep Retrofit and its dependencies
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }