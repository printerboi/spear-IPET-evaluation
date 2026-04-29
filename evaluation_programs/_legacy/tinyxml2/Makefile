.PHONY: tinyxml
.PHONY: tinyxml_examples
.PHONY: tinyxml-clean
.PHONY: clean

SHELL := /bin/bash
LLVM_PREFIX := /usr/lib/llvm-17/bin/
CLANG := $(LLVM_PREFIX)/clang
CLANGXX := $(LLVM_PREFIX)/clang++
LLVM_LINK := $(LLVM_PREFIX)/llvm-link
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis

TINYXML_SRC_DIR := ../_dependencies/tinyxml2
TINYXML_BUILD_DIR := ../_dependencies/.build/tinyxml2

TINYXML_INCLUDES := \
	-I$(TINYXML_SRC_DIR) \

EXAMPLE_BUILD_DIR := .build

EXAMPLE_SOURCES := $(wildcard *.cpp)
EXAMPLE_NAMES := $(basename $(notdir $(EXAMPLE_SOURCES)))

EXAMPLE_BC_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .bc,$(EXAMPLE_NAMES)))
EXAMPLE_LL_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .ll,$(EXAMPLE_NAMES)))
EXAMPLE_BINARIES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(EXAMPLE_NAMES))

tinyxml:
	mkdir -p "$(TINYXML_BUILD_DIR)"
	find "$(TINYXML_SRC_DIR)" -name 'tinyxml2.cpp' -not -path '*/test/*' -print0 | \
	while IFS= read -r -d '' file; do \
		relative_path="$${file#$(TINYXML_SRC_DIR)/}"; \
		output_path="$(TINYXML_BUILD_DIR)/$${relative_path%.c}.bc"; \
		output_directory="$$(dirname "$$output_path")"; \
		mkdir -p "$$output_directory"; \
		$(CLANG) -g -O0 -fPIC -Xclang -disable-O0-optnone -emit-llvm -c "$$file" $(TINYXML_INCLUDES) -o "$$output_path" || exit 1; \
	done
	find "$(TINYXML_BUILD_DIR)" -name '*.bc' ! -name 'tinyxml.bc' -print0 | \
	xargs -0 $(LLVM_LINK) -o "$(TINYXML_BUILD_DIR)/tinyxml.bc"
	$(LLVM_DIS) "$(TINYXML_BUILD_DIR)/tinyxml.bc" -o "$(TINYXML_BUILD_DIR)/tinyxml.ll"

tinyxml_examples: $(EXAMPLE_BINARIES) $(EXAMPLE_LL_FILES)

$(EXAMPLE_BUILD_DIR):
	mkdir -p "$(EXAMPLE_BUILD_DIR)"

$(EXAMPLE_BUILD_DIR)/%.bc: %.cpp | $(EXAMPLE_BUILD_DIR)
	$(CLANGXX) -g -O0 -disable-O0-optnone -fno-discard-value-names -emit-llvm -c "$<" $(TINYXML_INCLUDES) -o "$@"

$(EXAMPLE_BUILD_DIR)/%_combined.bc: $(EXAMPLE_BUILD_DIR)/%.bc $(TINYXML_BUILD_DIR)/tinyxml.bc | $(EXAMPLE_BUILD_DIR)
	$(LLVM_LINK) $^ -o "$@"

$(EXAMPLE_BUILD_DIR)/%.ll: $(EXAMPLE_BUILD_DIR)/%_combined.bc
	$(LLVM_DIS) "$<" -o "$@"

$(EXAMPLE_BUILD_DIR)/%: $(EXAMPLE_BUILD_DIR)/%_combined.bc
	$(CLANGXX) -O0 "$<" -o "$@"

tinyxml-clean:
	rm -rf "$(TINYXML_BUILD_DIR)"

clean:
	rm -rf "$(EXAMPLE_BUILD_DIR)"