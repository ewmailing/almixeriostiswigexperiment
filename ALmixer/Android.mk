LIBALMIXER_DIR := $(call my-dir)

###########################
#
# SDL shared library
#
###########################

include $(CLEAR_VARS)

LOCAL_MODULE := ALmixer

LOCAL_C_INCLUDES := $(LIBALMIXER_DIR)


LIBALMIXER_FILES := \
	$(LIBALMIXER_DIR)/ALmixer.c \
	$(LIBALMIXER_DIR)/CircularQueue.c \
	$(LIBALMIXER_DIR)/LinkedList.c \
	$(LIBALMIXER_DIR)/Isolated/ALmixer_RWops.c \
	$(LIBALMIXER_DIR)/Isolated/SimpleMutex.c \
	$(LIBALMIXER_DIR)/Isolated/SimpleThreadPosix.c \
	$(LIBALMIXER_DIR)/Isolated/SoundDecoder.c \
	$(LIBALMIXER_DIR)/Isolated/tErrorLib.c \
	$(LIBALMIXER_DIR)/Isolated/LGPL/wav.c \
	$(LIBALMIXER_DIR)/Isolated/LGPL/mpg123.c \
	$(LIBALMIXER_DIR)/Isolated/LGPL/oggtremor.c \
	$(LIBALMIXER_DIR)/Isolated/LGPL/SDL_sound_minimal.c \

LOCAL_SRC_FILES  := \
	$(LIBALMIXER_FILES)

LOCAL_LDLIBS := -lopenal -llog

#LOCAL_SHARED_LIBRARIES

include $(BUILD_SHARED_LIBRARY)
$(call import-module,openal)

