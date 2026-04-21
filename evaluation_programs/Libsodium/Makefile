.PHONY: libsodium
.PHONY: libsodium_examples
.PHONY: libsodium-clean
.PHONY: clean

SHELL := /bin/bash
LLVM_PREFIX := /usr/lib/llvm-17/bin/
CLANG := $(LLVM_PREFIX)/clang
CLANGXX := $(LLVM_PREFIX)/clang++
LLVM_LINK := $(LLVM_PREFIX)/llvm-link
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis

LIBSODIUM_SRC_DIR := ../dependencies/libsodium-1.0.22
LIBSODIUM_BUILD_DIR := ../dependencies/.build/libsodium

LIBSODIUM_INCLUDES := \
	-I$(LIBSODIUM_SRC_DIR)/src/libsodium/include \
	-I$(LIBSODIUM_SRC_DIR)/src/libsodium/include/sodium \
	-I$(LIBSODIUM_SRC_DIR) \
	-I$(LIBSODIUM_SRC_DIR)/src/libsodium

EXAMPLE_BUILD_DIR := .build

EXAMPLE_SOURCES := $(wildcard *.cpp)
EXAMPLE_NAMES := $(basename $(notdir $(EXAMPLE_SOURCES)))

EXAMPLE_BC_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .bc,$(EXAMPLE_NAMES)))
EXAMPLE_LL_FILES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(addsuffix .ll,$(EXAMPLE_NAMES)))
EXAMPLE_BINARIES := $(addprefix $(EXAMPLE_BUILD_DIR)/,$(EXAMPLE_NAMES))

libsodium:
	mkdir -p "$(LIBSODIUM_BUILD_DIR)"
	find "$(LIBSODIUM_SRC_DIR)" -name '*.c' -not -path '*/test/*' -print0 | \
	while IFS= read -r -d '' file; do \
		relative_path="$${file#$(LIBSODIUM_SRC_DIR)/}"; \
		output_path="$(LIBSODIUM_BUILD_DIR)/$${relative_path%.c}.bc"; \
		output_directory="$$(dirname "$$output_path")"; \
		mkdir -p "$$output_directory"; \
		$(CLANG) -O0 -fPIC -Xclang -disable-O0-optnone -emit-llvm -c "$$file" $(LIBSODIUM_INCLUDES) -o "$$output_path" || exit 1; \
	done
	find "$(LIBSODIUM_BUILD_DIR)" -name '*.bc' ! -name 'libsodium.bc' -print0 | \
	xargs -0 $(LLVM_LINK) -o "$(LIBSODIUM_BUILD_DIR)/libsodium.bc"
	$(LLVM_DIS) "$(LIBSODIUM_BUILD_DIR)/libsodium.bc" -o "$(LIBSODIUM_BUILD_DIR)/libsodium.ll"

libsodium_examples: $(EXAMPLE_BINARIES) $(EXAMPLE_LL_FILES)

$(EXAMPLE_BUILD_DIR):
	mkdir -p "$(EXAMPLE_BUILD_DIR)"

$(EXAMPLE_BUILD_DIR)/%.bc: %.cpp | $(EXAMPLE_BUILD_DIR)
	$(CLANGXX) -O0 -emit-llvm -c "$<" $(LIBSODIUM_INCLUDES) -o "$@"

$(EXAMPLE_BUILD_DIR)/%_combined.bc: $(EXAMPLE_BUILD_DIR)/%.bc $(LIBSODIUM_BUILD_DIR)/libsodium.bc | $(EXAMPLE_BUILD_DIR)
	$(LLVM_LINK) $^ -o "$@"

$(EXAMPLE_BUILD_DIR)/%.ll: $(EXAMPLE_BUILD_DIR)/%_combined.bc
	$(LLVM_DIS) "$<" -o "$@"

$(EXAMPLE_BUILD_DIR)/%: $(EXAMPLE_BUILD_DIR)/%_combined.bc
	$(CLANGXX) -O0 "$<" -o "$@"

libsodium-clean:
	rm -rf "$(LIBSODIUM_BUILD_DIR)"

clean:
	rm -rf "$(EXAMPLE_BUILD_DIR)"