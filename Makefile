# http://www.sqlite.org/download.html
SQLITE_YEAR     ?= 2016
SQLITE_VERSION  ?= 3120200
SQLITE_BASENAME := sqlite-amalgamation-$(SQLITE_VERSION)
SQLITE_URL      := http://www.sqlite.org/$(SQLITE_YEAR)/$(SQLITE_BASENAME).zip

# This flag should be called in a local context, see jni/Android.mk.
#CFLAGS += -D SQLITE_ENABLE_COLUMN_METADATA

# NDK parameters.
NDK_BUILD_EXEC := ndk-build
# http://www.cnblogs.com/rainduck/p/4177384.html
APP_PLATFORM := android-19
# Use 'all' to build targets for all platforms supported by Android.
APP_ABI := x86,armeabi-v7a

# Build/Compile
libs: build/sqlite3.c
    $(NDK_BUILD_EXEC) APP_PLATFORM=$(APP_PLATFORM) APP_ABI=$(APP_ABI)

# Unpack
build/sqlite3.c: $(SQLITE_BASENAME).zip
    unzip -oq "$<"
    rm -rf build
    mv "$(SQLITE_BASENAME)" build
    touch "$@"

# Download
$(SQLITE_BASENAME).zip:
    wget -N -c "$(SQLITE_URL)"

echo:
    echo $(SQLITE_URL)

clean:
    rm -f "$(SQLITE_BASENAME).zip"
    rm -rf "$(SQLITE_BASENAME)"
    rm -rf build
    rm -rf obj
    rm -rf libs
