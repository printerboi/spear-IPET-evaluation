.PHONY: stb
.PHONY: stb_examples
.PHONY: stb-clean
.PHONY: clean

SHELL := /bin/bash
LLVM_PREFIX := /usr/lib/llvm-17/bin/
CLANGXX := $(LLVM_PREFIX)/clang++
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis

STB_SRC_DIR := ../_dependencies/stb

STB_INCLUDES := \
	-I$(STB_SRC_DIR)

EXAMPLE_BUILD_DIR := .build

EXAMPLE_SOURCES := $(wildcard *.cpp)
EXAMPLE_NAMES := $(basename $(notdir $(EXAMPLE_SOURCES)))

EXAMPLE_BC_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .bc,$(EXAMPLE_NAMES)))
EXAMPLE_LL_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .ll,$(EXAMPLE_NAMES)))
EXAMPLE_BINARIES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(EXAMPLE_NAMES))

stb:
	test -d "$(STB_SRC_DIR)"

stb_examples: stb $(EXAMPLE_BINARIES) $(EXAMPLE_LL_FILES)

$(EXAMPLE_BUILD_DIR):
	mkdir -p "$(EXAMPLE_BUILD_DIR)"

$(EXAMPLE_BUILD_DIR)/%.bc: %.cpp | $(EXAMPLE_BUILD_DIR)
	$(CLANGXX) -g -O0 -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm -c "$<" $(STB_INCLUDES) -o "$@"

$(EXAMPLE_BUILD_DIR)/%.ll: $(EXAMPLE_BUILD_DIR)/%.bc
	$(LLVM_DIS) "$<" -o "$@"

$(EXAMPLE_BUILD_DIR)/%: $(EXAMPLE_BUILD_DIR)/%.bc
	$(CLANGXX) -O0 "$<" -o "$@"

stb-clean:
	@true

clean:
	rm -rf "$(EXAMPLE_BUILD_DIR)"