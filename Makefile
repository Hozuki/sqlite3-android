# http://www.sqlite.org/download.html
SQLITE_YEAR     ?= 2016
SQLITE_VERSION  ?= 3120100
SQLITE_BASENAME := sqlite-amalgamation-$(SQLITE_VERSION)
SQLITE_URL      := http://www.sqlite.org/$(SQLITE_YEAR)/$(SQLITE_BASENAME).zip

# NDK parameters.
NDK_BUILD_EXEC := ndk-build
# http://www.cnblogs.com/rainduck/p/4177384.html
APP_PLATFORM := android-19
APP_ABI := all

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

clean:
	rm -f "$(SQLITE_BASENAME).zip"
	rm -rf "$(SQLITE_BASENAME)"
	rm -rf build
	rm -rf obj
	rm -rf libs
