.PHONY: coreutils_wc
.PHONY: coreutils_wc-clean
.PHONY: clean

SHELL := /bin/bash

LLVM_PREFIX := /usr/lib/llvm-17/bin
CLANG := $(LLVM_PREFIX)/clang
LLVM_LINK := $(LLVM_PREFIX)/llvm-link
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis
LLVM_OPT := $(LLVM_PREFIX)/opt

KEEP_SYMBOLS := main

COREUTILS_ROOT_DIR := ../_dependencies/coreutils
COREUTILS_SRC_DIR := $(COREUTILS_ROOT_DIR)/src
COREUTILS_LIB_DIR := $(COREUTILS_ROOT_DIR)/lib
COREUTILS_BUILD_DIR := ../_dependencies/.build/coreutils_wc
COREUTILS_OBJECT_DIR := $(COREUTILS_BUILD_DIR)/objects
COREUTILS_GENERATED_STAMP := $(COREUTILS_BUILD_DIR)/generated_headers.stamp
COREUTILS_SHIM_HEADER := $(COREUTILS_BUILD_DIR)/coreutils_shim.h
COREUTILS_STUB_SOURCE := $(COREUTILS_BUILD_DIR)/coreutils_stubs.c

COREUTILS_INCLUDES := \
	-I$(COREUTILS_ROOT_DIR) \
	-I$(COREUTILS_SRC_DIR) \
	-I$(COREUTILS_LIB_DIR)

COREUTILS_DEFINES := \
	-D_GNU_SOURCE \
	-DO_BINARY=0 \
	-DO_SEARCH=0 \
	-DVersion=VERSION \
	-include $(COREUTILS_SHIM_HEADER)

WC_SOURCES := \
	$(COREUTILS_SRC_DIR)/wc.c \
	$(COREUTILS_LIB_DIR)/xalloc-die.c \
	$(COREUTILS_LIB_DIR)/xmalloc.c \
	$(COREUTILS_LIB_DIR)/xstrtol.c \
	$(COREUTILS_LIB_DIR)/safe-read.c \
	$(COREUTILS_LIB_DIR)/close-stream.c \
	$(COREUTILS_LIB_DIR)/fadvise.c \
	$(COREUTILS_LIB_DIR)/version-etc.c \
	$(COREUTILS_LIB_DIR)/progname.c \
	$(COREUTILS_LIB_DIR)/error.c \
	$(COREUTILS_LIB_DIR)/quotearg.c \
	$(COREUTILS_LIB_DIR)/exitfail.c \
	$(COREUTILS_LIB_DIR)/closeout.c \
	$(COREUTILS_STUB_SOURCE)

WC_OBJECTS := $(addprefix $(COREUTILS_OBJECT_DIR)/,$(notdir $(WC_SOURCES:.c=.bc)))

WC_COMBINED_FULL_BC := $(COREUTILS_BUILD_DIR)/wc_combined_full.bc
WC_COMBINED_BC := $(COREUTILS_BUILD_DIR)/wc_combined.bc
WC_LL := $(COREUTILS_BUILD_DIR)/wc.ll
WC_BINARY := $(COREUTILS_BUILD_DIR)/wc

coreutils_wc: $(WC_LL)

$(COREUTILS_BUILD_DIR):
	mkdir -p "$(COREUTILS_BUILD_DIR)"

$(COREUTILS_OBJECT_DIR):
	mkdir -p "$(COREUTILS_OBJECT_DIR)"

$(COREUTILS_GENERATED_STAMP): | $(COREUTILS_BUILD_DIR)
	printf '%s\n' \
		'#ifndef CONFIGMAKE_H' \
		'#define CONFIGMAKE_H' \
		'#define LOCALEDIR ""' \
		'#define DEFAULT_TMPDIR "/tmp"' \
		'#define GETGROUPS_T gid_t' \
		'#define SUID_C_DISPLAY_VERSION "UNKNOWN"' \
		'#endif' \
		> "$(COREUTILS_SRC_DIR)/configmake.h"
	printf '%s\n' \
		'#ifndef STDCKDINT_H' \
		'#define STDCKDINT_H' \
		'#define ckd_add(result, first, second) __builtin_add_overflow((first), (second), (result))' \
		'#define ckd_sub(result, first, second) __builtin_sub_overflow((first), (second), (result))' \
		'#define ckd_mul(result, first, second) __builtin_mul_overflow((first), (second), (result))' \
		'#endif' \
		> "$(COREUTILS_LIB_DIR)/stdckdint.h"
	printf '%s\n' \
		'#ifndef VERSION_H' \
		'#define VERSION_H' \
		'#define VERSION "9.5"' \
		'#endif' \
		> "$(COREUTILS_SRC_DIR)/version.h"
	printf '%s\n' \
		'#ifndef COREUTILS_SHIM_H' \
		'#define COREUTILS_SHIM_H' \
		'#include <stddef.h>' \
		'#include <stdint.h>' \
		'#include <stdbool.h>' \
		'#include <stdio.h>' \
		'#include <string.h>' \
		'#include <wchar.h>' \
		'#include <wctype.h>' \
		'#include <uchar.h>' \
		'#include <sys/stat.h>' \
		'#ifndef S_TYPEISTMO' \
		'#define S_TYPEISTMO(stat_buffer) 0' \
		'#endif' \
		'#ifndef S_TYPEISSHM' \
		'#define S_TYPEISSHM(stat_buffer) 0' \
		'#endif' \
		'#ifndef fpurge' \
		'#define fpurge(stream) fflush(stream)' \
		'#endif' \
		'#ifndef mbszero' \
		'#define mbszero(state_pointer) memset((state_pointer), 0, sizeof(*(state_pointer)))' \
		'#endif' \
		'#ifndef unreachable' \
		'#define unreachable() __builtin_unreachable()' \
		'#endif' \
		'#ifndef _GL_ATTRIBUTE_FORMAT_PRINTF_STANDARD' \
		'#define _GL_ATTRIBUTE_FORMAT_PRINTF_STANDARD(format_index, first_arg_index)' \
		'#endif' \
		'#ifndef _GL_ARG_NONNULL' \
		'#define _GL_ARG_NONNULL(params)' \
		'#endif' \
		'const char *getprogname(void);' \
		'void *rawmemchr(const void *buffer, int character);' \
		'int c32width(char32_t character);' \
		'char32_t btoc32(int character);' \
		'bool c32isprint(char32_t character);' \
		'#endif' \
		> "$(COREUTILS_SHIM_HEADER)"
	touch "$@"

$(COREUTILS_STUB_SOURCE): $(COREUTILS_GENERATED_STAMP) | $(COREUTILS_BUILD_DIR)
	printf '%s\n' \
		'#include <stdbool.h>' \
		'#include <uchar.h>' \
		'#include <ctype.h>' \
		'#include <stdio.h>' \
		'int c32width(char32_t character) {' \
		'    return character == 0 ? 0 : 1;' \
		'}' \
		'char32_t btoc32(int character) {' \
		'    return character == EOF ? (char32_t)-1 : (unsigned char) character;' \
		'}' \
		'bool c32isprint(char32_t character) {' \
		'    return character < 128 && isprint((unsigned char) character);' \
		'}' \
		> "$@"

$(COREUTILS_OBJECT_DIR)/%.bc: $(COREUTILS_SRC_DIR)/%.c $(COREUTILS_GENERATED_STAMP) | $(COREUTILS_OBJECT_DIR)
	$(CLANG) -std=gnu11 -g -O0 -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm \
		-c "$<" $(COREUTILS_DEFINES) $(COREUTILS_INCLUDES) -o "$@"

$(COREUTILS_OBJECT_DIR)/%.bc: $(COREUTILS_LIB_DIR)/%.c $(COREUTILS_GENERATED_STAMP) | $(COREUTILS_OBJECT_DIR)
	$(CLANG) -std=gnu11 -g -O0 -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm \
		-c "$<" $(COREUTILS_DEFINES) $(COREUTILS_INCLUDES) -o "$@"

$(COREUTILS_OBJECT_DIR)/%.bc: $(COREUTILS_BUILD_DIR)/%.c $(COREUTILS_GENERATED_STAMP) | $(COREUTILS_OBJECT_DIR)
	$(CLANG) -std=gnu11 -g -O0 -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm \
		-c "$<" $(COREUTILS_DEFINES) $(COREUTILS_INCLUDES) -o "$@"

$(WC_COMBINED_FULL_BC): $(WC_OBJECTS) | $(COREUTILS_BUILD_DIR)
	$(LLVM_LINK) $^ -o "$@"

$(WC_COMBINED_BC): $(WC_COMBINED_FULL_BC)
	$(LLVM_OPT) \
		-passes='internalize,globaldce,globalopt,instcombine,simplifycfg,early-cse,instcombine,simplifycfg,dce,adce,simplifycfg,globaldce' \
		-internalize-public-api-list=$(KEEP_SYMBOLS) \
		"$<" \
		-o "$@"

$(WC_LL): $(WC_COMBINED_BC)
	$(LLVM_DIS) "$<" -o "$@"


coreutils_wc-clean:
	rm -rf "$(COREUTILS_BUILD_DIR)"

clean:
	rm -rf "$(COREUTILS_BUILD_DIR)"