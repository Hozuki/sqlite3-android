LOCAL_PATH := $(call my-dir)

#BUILD_STATIC := 1
#BULID_STATIC_EXEC := 1
BUILD_DYNAMIC := 1
#BUILD_DYNAMIC_EXEC := 1

SQLITE_ENABLE_COLUMN_METADATA ?= -DSQLITE_ENABLE_COLUMN_METADATA

#
# Statically Linked
#

ifdef BUILD_STATIC
include $(CLEAR_VARS)
LOCAL_MODULE            := sqlite3-a
LOCAL_MODULE_FILENAME   := libsqlite3
LOCAL_SRC_FILES         := ../build/sqlite3.c
LOCAL_C_INCLUDES        := ../build
LOCAL_EXPORT_C_INCLUDES := ../build
LOCAL_CFLAGS            := -DSQLITE_THREADSAFE=1 $(SQLITE_ENABLE_COLUMN_METADATA)
include $(BUILD_STATIC_LIBRARY)

ifdef BUILD_STATIC_EXEC
include $(CLEAR_VARS)
LOCAL_MODULE            := sqlite3-static-cli
LOCAL_MODULE_FILENAME   := sqlite3-static
LOCAL_STATIC_LIBRARIES  := libsqlite3-a
LOCAL_SRC_FILES         := ../build/shell.c ../build/sqlite3.c
LOCAL_C_INCLUDES        := ../build
LOCAL_EXPORT_C_INCLUDES := ../build
LOCAL_CFLAGS            := -DSQLITE_THREADSAFE=1 -fPIE
LOCAL_LDFLAGS           := -fPIE -pie
include $(BUILD_EXECUTABLE)
endif
endif

#
# Dynamically Linked
#

ifdef BUILD_DYNAMIC
include $(CLEAR_VARS)
LOCAL_MODULE            := sqlite3-so
LOCAL_MODULE_FILENAME   := libsqlite3
LOCAL_SRC_FILES         := ../build/sqlite3.c
LOCAL_C_INCLUDES        := ../build
LOCAL_EXPORT_C_INCLUDES := ../build
LOCAL_CFLAGS            := -DSQLITE_THREADSAFE=1 $(SQLITE_ENABLE_COLUMN_METADATA)
include $(BUILD_SHARED_LIBRARY)

ifdef BUILD_DYNAMIC_EXEC
include $(CLEAR_VARS)
LOCAL_MODULE            := sqlite3-dynamic-cli
LOCAL_MODULE_FILENAME   := sqlite3-dynamic
LOCAL_SHARED_LIBRARIES  := libsqlite3-so
LOCAL_SRC_FILES         := ../build/shell.c ../build/sqlite3.c
LOCAL_C_INCLUDES        := ../build
LOCAL_EXPORT_C_INCLUDES := ../build
LOCAL_CFLAGS            := -DSQLITE_THREADSAFE=1 -fPIE
LOCAL_LDFLAGS           := -fPIE -pie
include $(BUILD_EXECUTABLE)
endif
endif
