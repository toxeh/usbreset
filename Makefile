#############################################################################
#
#	Makefile for building the gpio application
#
#############################################################################

APPNAME		= usbreset

export CROSS_COMPILE = /Volumes/android/platform_prebuilt/darwin-x86/toolchain/arm-linux-androideabi-4.4.x/bin/arm-linux-androideabi-

ARCH=arm

CC		= $(CROSS_COMPILE)gcc
LD		= $(CROSS_COMPILE)ld
AR		= $(CROSS_COMPILE)ar

SYSROOT = --sysroot /Volumes/android/platform_prebuilt/ndk/android-ndk-r8/platforms/android-14/arch-arm

CFLAGS += \
	-std=gnu99 \
	-Wall \
	-Wimplicit \
	-Wpointer-arith \
	-Wswitch \
	-Wredundant-decls \
	-Wreturn-type \
	-Wshadow \
	-Wunused \
	-Wcast-qual \
	-Wnested-externs \
	-Wmissing-prototypes \
	-Wstrict-prototypes \
	-Wmissing-declarations \
	-I ../lib \
	-I /Volumes/android/platform_prebuilt/ndk/android-ndk-r8/platforms/android-14/arch-arm/usr/include
	    

DEP_OUTPUT_OPTION = -MMD -MF $(@:.o=.d)

OBJ_FILES = obj/usbreset.o

$(APPNAME) : $(OBJ_FILES)
	@echo "Creating executable $@ ..."
	$(CC) ${SYSROOT} -o $@ -static -L ../lib $^

.PHONY: %.d
%.d: ;

obj/%.o : %.c %.d
	@echo "Compiling $< ..."
	$(COMPILE.c) $(DEP_OUTPUT_OPTION) $(OUTPUT_OPTION) $<

clean:
	rm -rf $(APPNAME) obj/*.o obj/*.d

DEP_FILES = $(strip $(OBJ_FILES:.o=.d))

ifneq ($(DEP_FILES),)
ifeq ($(strip $(filter clean%, $(MAKECMDGOALS))),)
-include $(DEP_FILES)
endif
endif

