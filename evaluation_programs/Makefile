.PHONY: libsodium
.PHONY libsodium_example
.PHONY: libsodium-clean

LLVM_PREFIX := /opt/homebrew/opt/llvm@17/bin
CLANG := $(LLVM_PREFIX)/clang
LLVM_LINK := $(LLVM_PREFIX)/llvm-link
LLVM_DIS := $(LLVM_PREFIX)/llvm-dis

LIBSODIUM_SRC_DIR := dependencies/libsodium-1.0.22
LIBSODIUM_BUILD_DIR := dependencies/.build/libsodium

LIBSODIUM_INCLUDES := \
	-I$(LIBSODIUM_SRC_DIR)/src/libsodium/include \
	-I$(LIBSODIUM_SRC_DIR)/src/libsodium/include/sodium \
	-I$(LIBSODIUM_SRC_DIR) \
	-I$(LIBSODIUM_SRC_DIR)/src/libsodium

EXAMPLE_SRC := Libsodium/test.cpp

EXAMPLE_BUILD_DIR := libsodium/.build/libsodium_example
EXAMPLE_BC := $(EXAMPLE_BUILD_DIR)/test.bc
EXAMPLE_COMBINED_BC := $(EXAMPLE_BUILD_DIR)/combined.bc
EXAMPLE_LL := $(EXAMPLE_BUILD_DIR)/combined.ll
EXAMPLE_BIN := $(EXAMPLE_BUILD_DIR)/test

libsodium:
	mkdir -p "$(LIBSODIUM_BUILD_DIR)"
	find "$(LIBSODIUM_SRC_DIR)" -name '*.c' -not -path '*/test/*' -print0 | \
	while IFS= read -r -d '' file; do \
		relative_path="$${file#$(LIBSODIUM_SRC_DIR)/}"; \
		output_path="$(LIBSODIUM_BUILD_DIR)/$${relative_path%.c}.bc"; \
		output_directory="$$(dirname "$$output_path")"; \
		mkdir -p "$$output_directory"; \
		$(CLANG) -O0 -arch arm64 -fPIC -Xclang -disable-O0-optnone -emit-llvm -c "$$file" $(LIBSODIUM_INCLUDES) -o "$$output_path" || exit 1; \
	done
	find "$(LIBSODIUM_BUILD_DIR)" -name '*.bc' -print0 | \
	xargs -0 $(LLVM_LINK) -o "$(LIBSODIUM_BUILD_DIR)/libsodium.bc"
	$(LLVM_DIS) "$(LIBSODIUM_BUILD_DIR)/libsodium.bc" -o "$(LIBSODIUM_BUILD_DIR)/libsodium.ll"

libsodium-example:
	mkdir -p "$(EXAMPLE_BUILD_DIR)"

	# Compile test.cpp to LLVM bitcode
	$(CLANG) -O0 -arch arm64 -emit-llvm -c $(EXAMPLE_SRC) \
		$(LIBSODIUM_INCLUDES) \
		-o $(EXAMPLE_BC)

	# Link with libsodium bitcode
	$(LLVM_LINK) \
		$(EXAMPLE_BC) \
		$(LIBSODIUM_BUILD_DIR)/libsodium.bc \
		-o $(EXAMPLE_COMBINED_BC)

	# Generate human-readable LLVM IR
	$(LLVM_DIS) $(EXAMPLE_COMBINED_BC) -o $(EXAMPLE_LL)

	# Build executable from combined bitcode
	$(CLANG) -O0 -arch arm64 $(EXAMPLE_COMBINED_BC) -o $(EXAMPLE_BIN)


libsodium-clean:
	rm -rf "$(LIBSODIUM_BUILD_DIR)"