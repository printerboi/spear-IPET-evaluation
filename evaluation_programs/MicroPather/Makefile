.PHONY: micropather
.PHONY: micropather_examples
.PHONY: micropather-clean
.PHONY: clean

SHELL := /bin/bash
LLVM_PREFIX := /usr/lib/llvm-17/bin
CLANGXX := $(LLVM_PREFIX)/clang++
LLVM_LINK := $(LLVM_PREFIX)/llvm-link
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis
LLVM_OPT := $(LLVM_PREFIX)/opt

KEEP_SYMBOLS := main

MICROPATHER_SRC_DIR := ../_dependencies/MicroPather
MICROPATHER_BUILD_DIR := ../_dependencies/.build/micropather

MICROPATHER_INCLUDES := \
	-I$(MICROPATHER_SRC_DIR)

EXAMPLE_BUILD_DIR := .build

EXAMPLE_SOURCES := $(wildcard *.cpp)
EXAMPLE_NAMES := $(basename $(notdir $(EXAMPLE_SOURCES)))

EXAMPLE_BC_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .bc,$(EXAMPLE_NAMES)))
EXAMPLE_LL_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .ll,$(EXAMPLE_NAMES)))
EXAMPLE_BINARIES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(EXAMPLE_NAMES))

MICROPATHER_BC := $(MICROPATHER_BUILD_DIR)/micropather.bc

micropather:
	mkdir -p "$(MICROPATHER_BUILD_DIR)"
	$(CLANGXX) -g -O0 -fPIC -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm \
		-c "$(MICROPATHER_SRC_DIR)/micropather.cpp" \
		$(MICROPATHER_INCLUDES) \
		-o "$(MICROPATHER_BC)"
	$(LLVM_DIS) "$(MICROPATHER_BC)" -o "$(MICROPATHER_BUILD_DIR)/micropather.ll"

micropather_examples: micropather $(EXAMPLE_BINARIES) $(EXAMPLE_LL_FILES)

$(EXAMPLE_BUILD_DIR):
	mkdir -p "$(EXAMPLE_BUILD_DIR)"

$(EXAMPLE_BUILD_DIR)/%.bc: %.cpp | $(EXAMPLE_BUILD_DIR)
	$(CLANGXX) -g -O0 -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm \
		-c "$<" $(MICROPATHER_INCLUDES) -o "$@"

$(EXAMPLE_BUILD_DIR)/%_combined_full.bc: $(EXAMPLE_BUILD_DIR)/%.bc $(MICROPATHER_BC) | $(EXAMPLE_BUILD_DIR)
	$(LLVM_LINK) $^ -o "$@"

$(EXAMPLE_BUILD_DIR)/%_combined.bc: $(EXAMPLE_BUILD_DIR)/%_combined_full.bc
	$(LLVM_OPT) \
		-passes='internalize,globaldce,globalopt,instcombine,simplifycfg,early-cse,instcombine,simplifycfg,dce,adce,simplifycfg,globaldce' \
		-internalize-public-api-list=$(KEEP_SYMBOLS) \
		"$<" \
		-o "$@"

$(EXAMPLE_BUILD_DIR)/%.ll: $(EXAMPLE_BUILD_DIR)/%_combined.bc
	$(LLVM_DIS) "$<" -o "$@"

$(EXAMPLE_BUILD_DIR)/%: $(EXAMPLE_BUILD_DIR)/%_combined.bc
	$(CLANGXX) -O0 "$<" -o "$@"

micropather-clean:
	rm -rf "$(MICROPATHER_BUILD_DIR)"

clean:
	rm -rf "$(EXAMPLE_BUILD_DIR)"