.PHONY: coreutils
.PHONY: clean

SHELL := /bin/bash

LLVM_PREFIX := /usr/lib/llvm-17/bin
CLANG := $(LLVM_PREFIX)/clang
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis

COREUTILS_TOOLS := wc cat sort uniq tail

COREUTILS_ROOT_DIR := ../_dependencies/coreutils
COREUTILS_SRC_DIR := $(COREUTILS_ROOT_DIR)/src
COREUTILS_LIB_DIR := $(COREUTILS_ROOT_DIR)/lib

COREUTILS_BUILD_DIR := .build
COREUTIL_ORIGIN_DIR := ../_dependencies/.build/coreutils
COREUTILS_OBJECT_DIR := $(COREUTIL_ORIGIN_DIR)/objects

COREUTILS_DEFINES := \
	-D_GNU_SOURCE

COREUTILS_INCLUDES := \
	-I$(COREUTILS_ROOT_DIR) \
	-I$(COREUTILS_SRC_DIR) \
	-I$(COREUTILS_LIB_DIR)

COREUTILS_LINK_OBJECTS := \
	$(COREUTILS_SRC_DIR)/version.o \
	$(COREUTILS_SRC_DIR)/iopoll.o

COREUTILS_LINK_LIBS := \
	$(COREUTILS_SRC_DIR)/libwc_avx2.a \
	$(COREUTILS_LIB_DIR)/libcoreutils.a \
	-lcrypto \
	-lm

define TOOL_RULES
$(1)_SOURCE := $$(COREUTILS_SRC_DIR)/$(1).c

$(1)_BC := $$(COREUTILS_OBJECT_DIR)/$(1).bc
$(1)_LL := $$(COREUTILS_BUILD_DIR)/$(1).ll
$(1)_BINARY := $$(COREUTILS_BUILD_DIR)/$(1)

.PHONY: coreutils_$(1)
coreutils_$(1): $$($(1)_LL) $$($(1)_BINARY)

$$($(1)_BC): $$($(1)_SOURCE) | $$(COREUTILS_OBJECT_DIR)
	$$(CLANG) \
		-std=gnu11 \
		-g \
		-O0 \
		-Xclang -disable-O0-optnone \
		-fno-discard-value-names \
		-emit-llvm \
		-c "$$<" \
		$$(COREUTILS_DEFINES) \
		$$(COREUTILS_INCLUDES) \
		-o "$$@"

$$($(1)_LL): $$($(1)_BC)
	$$(LLVM_DIS) "$$<" -o "$$@"

$$($(1)_BINARY): $$($(1)_BC) $$(COREUTILS_LINK_OBJECTS) $$(COREUTILS_LINK_LIBS)
	$$(CLANG) \
		"$$<" \
		$$(COREUTILS_LINK_OBJECTS) \
		$$(COREUTILS_LINK_LIBS) \
		-o "$$@"
endef

$(foreach tool,$(COREUTILS_TOOLS),$(eval $(call TOOL_RULES,$(tool))))

coreutils: $(addprefix coreutils_,$(COREUTILS_TOOLS))

$(COREUTILS_BUILD_DIR):
	mkdir -p "$(COREUTILS_BUILD_DIR)"

$(COREUTILS_OBJECT_DIR): | $(COREUTILS_BUILD_DIR)
	mkdir -p "$(COREUTILS_OBJECT_DIR)"

clean:
	rm -rf "$(COREUTILS_BUILD_DIR)"