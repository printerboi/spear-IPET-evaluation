/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <lz4.h>

#include <cstring>
#include <iostream>
#include <vector>

int main() {
    // Define the example input size
    // 20MB Size
    const int inputSize = 20 * 1024;

    // Create a buffer for the input
    std::vector<char> originalBuffer(inputSize);

    // Fill the input buffer
    for (int byteIndex = 0; byteIndex < inputSize; ++byteIndex) {
        originalBuffer[byteIndex] = static_cast<char>('A' + (byteIndex % 4));
    }

    // Calculate how big the compressed data will be
    const int maximumCompressedSize = LZ4_compressBound(inputSize);

    // Create a buffer for the compressed data
    std::vector<char> compressedBuffer(maximumCompressedSize);

    // Execute the compression
    const int compressedSize = LZ4_compress_default(
        originalBuffer.data(),
        compressedBuffer.data(),
        inputSize,
        maximumCompressedSize
    );

    // Error handling
    if (compressedSize <= 0) {
        std::cerr << "Compression failed!" << std::endl;
    }

    // Create a buffer for the decompression
    std::vector<char> decompressedBuffer(inputSize);

    // Execute the decompression
    const int decompressedSize = LZ4_decompress_safe(
        compressedBuffer.data(),
        decompressedBuffer.data(),
        compressedSize,
        inputSize
    );

    // Error handling decompression
    if (decompressedSize < 0) {
        std::cerr << "Decompression failed!" << std::endl;
        return 1;
    }

    // Error handling size differences after decompression
    if (decompressedSize != inputSize) {
        std::cerr << "Unexpected decompressed size" << std::endl;
        return 1;
    }

    std::cout << "Compressed size: " << compressedSize << std::endl;
    std::cout << "Decompressed size: " << decompressedSize << std::endl;

    return 0;
}