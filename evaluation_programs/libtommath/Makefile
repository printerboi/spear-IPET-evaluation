.PHONY: libtommath
.PHONY: libtommath_examples
.PHONY: libtommath-clean
.PHONY: clean

SHELL := /bin/bash
LLVM_PREFIX := /usr/lib/llvm-17/bin
CLANGXX := $(LLVM_PREFIX)/clang++
LLVM_LINK := $(LLVM_PREFIX)/llvm-link
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis
LLVM_OPT := $(LLVM_PREFIX)/opt

KEEP_SYMBOLS := main

LIBTOMMATH_SRC_DIR := ../_dependencies/libtommath
LIBTOMMATH_BUILD_DIR := ../_dependencies/.build/libtommath

LIBTOMMATH_INCLUDES := \
	-I$(LIBTOMMATH_SRC_DIR)

EXAMPLE_BUILD_DIR := .build

EXAMPLE_SOURCES := $(wildcard *.cpp)
EXAMPLE_NAMES := $(basename $(notdir $(EXAMPLE_SOURCES)))

EXAMPLE_BC_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .bc,$(EXAMPLE_NAMES)))
EXAMPLE_LL_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .ll,$(EXAMPLE_NAMES)))
EXAMPLE_BINARIES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(EXAMPLE_NAMES))

LIBTOMMATH_BC := $(LIBTOMMATH_BUILD_DIR)/libtommath.bc

# ---- Build LibTomMath as single bitcode file ----

LIBTOMMATH_SOURCES := $(wildcard $(LIBTOMMATH_SRC_DIR)/*.c)
LIBTOMMATH_OBJECTS := $(patsubst $(LIBTOMMATH_SRC_DIR)/%.c,$(LIBTOMMATH_BUILD_DIR)/%.bc,$(LIBTOMMATH_SOURCES))

libtommath:
	mkdir -p "$(LIBTOMMATH_BUILD_DIR)"
	$(MAKE) $(LIBTOMMATH_OBJECTS)
	$(LLVM_LINK) $(LIBTOMMATH_OBJECTS) -o "$(LIBTOMMATH_BC)"
	$(LLVM_DIS) "$(LIBTOMMATH_BC)" -o "$(LIBTOMMATH_BUILD_DIR)/libtommath.ll"

$(LIBTOMMATH_BUILD_DIR)/%.bc: $(LIBTOMMATH_SRC_DIR)/%.c | $(LIBTOMMATH_BUILD_DIR)
	$(CLANGXX) -g -O0 -fPIC -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm \
		-c "$<" $(LIBTOMMATH_INCLUDES) -o "$@"

# ---- Example pipeline (identical to your MicroPather setup) ----

libtommath_examples: libtommath $(EXAMPLE_BINARIES) $(EXAMPLE_LL_FILES)

$(EXAMPLE_BUILD_DIR):
	mkdir -p "$(EXAMPLE_BUILD_DIR)"

$(EXAMPLE_BUILD_DIR)/%.bc: %.cpp | $(EXAMPLE_BUILD_DIR)
	$(CLANGXX) -g -O0 -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm \
		-c "$<" $(LIBTOMMATH_INCLUDES) -o "$@"

$(EXAMPLE_BUILD_DIR)/%_combined_full.bc: $(EXAMPLE_BUILD_DIR)/%.bc $(LIBTOMMATH_BC) | $(EXAMPLE_BUILD_DIR)
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

libtommath-clean:
	rm -rf "$(LIBTOMMATH_BUILD_DIR)"

clean:
	rm -rf "$(EXAMPLE_BUILD_DIR)"