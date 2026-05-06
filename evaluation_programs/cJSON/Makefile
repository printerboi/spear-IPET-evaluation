.PHONY: cjson
.PHONY: cjson_examples
.PHONY: cjson-clean
.PHONY: clean

SHELL := /bin/bash
LLVM_PREFIX := /usr/lib/llvm-17/bin
CLANGXX := $(LLVM_PREFIX)/clang++
LLVM_LINK := $(LLVM_PREFIX)/llvm-link
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis
LLVM_OPT := $(LLVM_PREFIX)/opt

KEEP_SYMBOLS := main

CJSON_SRC_DIR := ../_dependencies/cJSON
CJSON_BUILD_DIR := ../_dependencies/.build/cjson

CJSON_INCLUDES := \
	-I$(CJSON_SRC_DIR)

EXAMPLE_BUILD_DIR := .build

EXAMPLE_SOURCES := $(wildcard *.cpp)
EXAMPLE_NAMES := $(basename $(notdir $(EXAMPLE_SOURCES)))

EXAMPLE_BC_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .bc,$(EXAMPLE_NAMES)))
EXAMPLE_LL_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .ll,$(EXAMPLE_NAMES)))
EXAMPLE_BINARIES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(EXAMPLE_NAMES))

CJSON_BC := $(CJSON_BUILD_DIR)/cjson.bc

# ---- Build cJSON as single bitcode file ----

CJSON_SOURCES := $(CJSON_SRC_DIR)/cJSON.c
CJSON_OBJECTS := $(patsubst $(CJSON_SRC_DIR)/%.c,$(CJSON_BUILD_DIR)/%.bc,$(CJSON_SOURCES))

cjson:
	mkdir -p "$(CJSON_BUILD_DIR)"
	$(MAKE) $(CJSON_OBJECTS)
	$(LLVM_LINK) $(CJSON_OBJECTS) -o "$(CJSON_BC)"
	$(LLVM_DIS) "$(CJSON_BC)" -o "$(CJSON_BUILD_DIR)/cjson.ll"

$(CJSON_BUILD_DIR)/%.bc: $(CJSON_SRC_DIR)/%.c | $(CJSON_BUILD_DIR)
	$(CLANGXX) -g -O0 -fPIC -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm \
		-c "$<" $(CJSON_INCLUDES) -o "$@"

cjson_examples: cjson $(EXAMPLE_BINARIES) $(EXAMPLE_LL_FILES)

$(EXAMPLE_BUILD_DIR):
	mkdir -p "$(EXAMPLE_BUILD_DIR)"

$(EXAMPLE_BUILD_DIR)/%.bc: %.cpp | $(EXAMPLE_BUILD_DIR)
	$(CLANGXX) -g -O0 -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm \
		-c "$<" $(CJSON_INCLUDES) -o "$@"

$(EXAMPLE_BUILD_DIR)/%_combined_full.bc: $(EXAMPLE_BUILD_DIR)/%.bc $(CJSON_BC) | $(EXAMPLE_BUILD_DIR)
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

cjson-clean:
	rm -rf "$(CJSON_BUILD_DIR)"

clean:
	rm -rf "$(EXAMPLE_BUILD_DIR)"