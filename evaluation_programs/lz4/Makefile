.PHONY: lz4
.PHONY: lz4_examples
.PHONY: lz4-clean
.PHONY: clean

SHELL := /bin/bash

LLVM_PREFIX := /usr/lib/llvm-17/bin
CLANG := $(LLVM_PREFIX)/clang
CLANGXX := $(LLVM_PREFIX)/clang++
LLVM_LINK := $(LLVM_PREFIX)/llvm-link
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis
LLVM_OPT := $(LLVM_PREFIX)/opt

KEEP_SYMBOLS := main

LZ4_SOURCE_DIR := ../_dependencies/lz4
LZ4_BUILD_DIR := ../_dependencies/.build/lz4

LZ4_INCLUDE_FLAGS := \
	-I$(LZ4_SOURCE_DIR)/lib

LZ4_COMPILE_FLAGS := \
	-g \
	-O0 \
	-fPIC \
	-Xclang -disable-O0-optnone \
	-fno-discard-value-names \
	-emit-llvm \
	-c

EXAMPLE_BUILD_DIR := .build

EXAMPLE_SOURCE_FILES := $(wildcard *.cpp)
EXAMPLE_NAMES := $(basename $(notdir $(EXAMPLE_SOURCE_FILES)))

EXAMPLE_LLVM_IR_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .ll,$(EXAMPLE_NAMES)))
EXAMPLE_BINARIES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(EXAMPLE_NAMES))

lz4: $(LZ4_BUILD_DIR)/lz4.bc $(LZ4_BUILD_DIR)/lz4.ll

lz4_examples: lz4 $(EXAMPLE_BINARIES) $(EXAMPLE_LLVM_IR_FILES)

$(LZ4_BUILD_DIR):
	mkdir -p "$(LZ4_BUILD_DIR)"

$(EXAMPLE_BUILD_DIR):
	mkdir -p "$(EXAMPLE_BUILD_DIR)"

$(LZ4_BUILD_DIR)/lz4.bc: $(LZ4_SOURCE_DIR)/lib/lz4.c | $(LZ4_BUILD_DIR)
	$(CLANG) \
		$(LZ4_COMPILE_FLAGS) \
		$(LZ4_INCLUDE_FLAGS) \
		"$<" \
		-o "$@"

$(LZ4_BUILD_DIR)/lz4.ll: $(LZ4_BUILD_DIR)/lz4.bc
	$(LLVM_DIS) "$<" -o "$@"

$(EXAMPLE_BUILD_DIR)/%.bc: %.cpp | $(EXAMPLE_BUILD_DIR)
	$(CLANGXX) \
		$(LZ4_COMPILE_FLAGS) \
		$(LZ4_INCLUDE_FLAGS) \
		"$<" \
		-o "$@"

$(EXAMPLE_BUILD_DIR)/%_combined_full.bc: $(EXAMPLE_BUILD_DIR)/%.bc $(LZ4_BUILD_DIR)/lz4.bc | $(EXAMPLE_BUILD_DIR)
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

lz4-clean:
	rm -rf "$(LZ4_BUILD_DIR)"

clean:
	rm -rf "$(EXAMPLE_BUILD_DIR)"