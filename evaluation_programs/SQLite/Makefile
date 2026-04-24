.PHONY: sqlite
.PHONY: sqlite_examples
.PHONY: sqlite-clean
.PHONY: clean

SHELL := /bin/bash

llvm_PREFIX := /usr/lib/llvm-17/bin
clang_C := $(llvm_PREFIX)/clang
clang_CXX := $(llvm_PREFIX)/clang++
llvm_LINK := $(llvm_PREFIX)/llvm-link
llvm_DIS := $(llvm_PREFIX)/llvm-dis
llvm_OPT := $(llvm_PREFIX)/opt

sqlite_SOURCE_DIR := ../_dependencies/sqlite
sqlite_BUILD_DIR := ../_dependencies/.build/sqlite

sqlite_INCLUDE_FLAGS := \
	-I$(sqlite_SOURCE_DIR)

sqlite_PREPROCESSOR_FLAGS := \
	-DSQLITE_THREADSAFE=0 \
	-DSQLITE_OMIT_LOAD_EXTENSION \
	-DSQLITE_OMIT_SHARED_CACHE \
	-DSQLITE_OMIT_PROGRESS_CALLBACK \
	-DSQLITE_OMIT_DEPRECATED \
	-DSQLITE_OMIT_TRACE \
	-DSQLITE_OMIT_UTF16

sqlite_COMPILE_FLAGS := \
	-O0 \
	-fPIC \
	-Xclang -disable-O0-optnone \
	-fno-discard-value-names \
	-emit-llvm \
	-c

example_BUILD_DIR := .build

example_SOURCE_FILES := $(wildcard *.cpp)
example_NAMES := $(basename $(notdir $(example_SOURCE_FILES)))

example_BITCODE_FILES := $(addprefix $(example_BUILD_DIR)/,$(addsuffix .bc,$(example_NAMES)))
example_COMBINED_BITCODE_FILES := $(addprefix $(example_BUILD_DIR)/,$(addsuffix _combined.bc,$(example_NAMES)))
example_PRUNED_BITCODE_FILES := $(addprefix $(example_BUILD_DIR)/,$(addsuffix _pruned.bc,$(example_NAMES)))
example_LLVM_IR_FILES := $(addprefix $(example_BUILD_DIR)/,$(addsuffix .ll,$(example_NAMES)))
example_BINARIES := $(addprefix $(example_BUILD_DIR)/,$(example_NAMES))

sqlite: $(sqlite_BUILD_DIR)/sqlite.bc

sqlite_examples: $(example_BINARIES) $(example_LLVM_IR_FILES)

$(sqlite_BUILD_DIR):
	mkdir -p "$(sqlite_BUILD_DIR)"

$(example_BUILD_DIR):
	mkdir -p "$(example_BUILD_DIR)"

$(sqlite_BUILD_DIR)/sqlite.bc: $(sqlite_SOURCE_DIR)/sqlite3.c | $(sqlite_BUILD_DIR)
	# Compile only the SQLite amalgamation into LLVM bitcode.
	$(clang_C) \
		$(sqlite_COMPILE_FLAGS) \
		$(sqlite_INCLUDE_FLAGS) \
		$(sqlite_PREPROCESSOR_FLAGS) \
		"$<" \
		-o "$@"

$(sqlite_BUILD_DIR)/sqlite.ll: $(sqlite_BUILD_DIR)/sqlite.bc
	# Disassemble SQLite bitcode into textual LLVM IR for inspection.
	$(llvm_DIS) "$<" -o "$@"

$(example_BUILD_DIR)/%.bc: %.cpp | $(example_BUILD_DIR)
	# Compile the example source into LLVM bitcode.
	$(clang_CXX) \
		-g \
		-O0 \
		-Xclang -disable-O0-optnone \
		-fno-discard-value-names \
		-emit-llvm \
		-c \
		"$<" \
		$(sqlite_INCLUDE_FLAGS) \
		-o "$@"

$(example_BUILD_DIR)/%_combined.bc: $(example_BUILD_DIR)/%.bc $(sqlite_BUILD_DIR)/sqlite.bc | $(example_BUILD_DIR)
	# Link the example bitcode with the SQLite bitcode.
	$(llvm_LINK) $^ -o "$@"

$(example_BUILD_DIR)/%_pruned.bc: $(example_BUILD_DIR)/%_combined.bc
	# Keep main public, internalize everything else, then remove unreachable globals and functions.
	$(llvm_OPT) \
		-passes=internalize,globaldce \
		-internalize-public-api-list=main \
		"$<" \
		-o "$@"

$(example_BUILD_DIR)/%.ll: $(example_BUILD_DIR)/%_pruned.bc
	# Disassemble the pruned module into textual LLVM IR.
	$(llvm_DIS) "$<" -o "$@"

$(example_BUILD_DIR)/%: $(example_BUILD_DIR)/%_pruned.bc
	# Build the runnable binary from the pruned LLVM bitcode module.
	$(clang_CXX) -O0 "$<" -o "$@"

sqlite-clean:
	rm -rf "$(sqlite_BUILD_DIR)"

clean:
	rm -rf "$(example_BUILD_DIR)"