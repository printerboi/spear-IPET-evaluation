/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <lz4hc.h>

#include <cstring>
#include <iostream>
#include <vector>

int main() {
    // Define the example input size
    // 20MB Size
    const int inputSize = 20 * 1024;
    const int compressionLevel = 12;

    // Create a buffer for the input
    std::vector<char> inputBuffer(inputSize);

    // Fill the input buffer
    for(int i=0; i < inputSize; i++) {
        inputBuffer[i] = static_cast<char>(i % 256);
    }

    // Calculate how big the compressed data will be
    int maxCompressedSize = LZ4_compressBound(inputSize);
    
    // Create a buffer for the compressed data
    std::vector<char> compressedBuffer(maxCompressedSize);

    // Execute the compression
    int compressedSize = LZ4_compress_HC(
        inputBuffer.data(),
        compressedBuffer.data(),
        inputSize,
        maxCompressedSize,
        compressionLevel
    );

    // Error handling
    if (compressedSize <= 0) {
        std::cerr << "Compression failed!" << std::endl;
    }

    std::cout << "Input size: " << inputSize << std::endl;
    std::cout << "Compressed size: " << compressedSize << std::endl;

    return 0;
}