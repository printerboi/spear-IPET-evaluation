/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <lz4.h>

#include <cstring>
#include <iostream>
#include <vector>

int main() {
    // Define the ring buffer size
    const int ringBufferSize = 64 * 1024;

    // Define the chunk size that will be compressed per iteration
    const int chunkSize = 4 * 1024;

    // Define how many chunks should be processed
    const int numberOfChunks = 8;

    // Create the ring buffer
    std::vector<char> ringBuffer(ringBufferSize);

    // Create and initialize the LZ4 streaming state
    LZ4_stream_t* compressionStream = LZ4_createStream();

    if (compressionStream == nullptr) {
        std::cerr << "Failed to create LZ4 stream!" << std::endl;
        return 1;
    }

    // Current write position inside the ring buffer
    int writePosition = 0;

    // Compress multiple chunks
    for (int chunkIndex = 0; chunkIndex < numberOfChunks; chunkIndex++) {

        // Wrap around when reaching the end of the ring buffer
        if (writePosition + chunkSize > ringBufferSize) {
            writePosition = 0;
        }

        // Fill the current chunk with example data
        for (int i = 0; i < chunkSize; i++) {
            ringBuffer[writePosition + i] = static_cast<char>((chunkIndex + i) % 256);
        }

        // Calculate maximum compressed size for this chunk
        int maxCompressedSize = LZ4_compressBound(chunkSize);

        // Create buffer for compressed data
        std::vector<char> compressedBuffer(maxCompressedSize);

        // Compress using streaming/ring-buffer mode
        int compressedSize = LZ4_compress_fast_continue(
            compressionStream,
            ringBuffer.data() + writePosition,
            compressedBuffer.data(),
            chunkSize,
            maxCompressedSize,
            1
        );

        // Error handling
        if (compressedSize <= 0) {
            std::cerr << "Compression failed for chunk "
                      << chunkIndex
                      << "!"
                      << std::endl;

            LZ4_freeStream(compressionStream);
            return 1;
        }

        std::cout << "Chunk "
                  << chunkIndex
                  << " compressed from "
                  << chunkSize
                  << " bytes to "
                  << compressedSize
                  << " bytes"
                  << std::endl;

        // Advance the ring buffer position
        writePosition += chunkSize;
    }

    // Free the streaming state
    LZ4_freeStream(compressionStream);

    return 0;
}