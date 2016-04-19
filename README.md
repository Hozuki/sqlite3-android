# SQLite build scripts for Android

*The original readme from the upstream repo is [here](README-original.md).*

This fork did several enhancements:

+ The publishing year is split out to a new variable. It is less likely to forget setting this since the year is now 2016, rather than the inlined '2014'.
+ The path to NDK building script is split out to a new variable.
+ Added 2 parameters for NDK build script.
  + `APP_PLATFORM`: specify Android API version.
  + `APP_ABI`: specify target architecture (X86, ARM, etc.).
