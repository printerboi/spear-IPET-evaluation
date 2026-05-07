/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <lz4.h>

#include <fstream>
#include <iostream>
#include <vector>
#include <string>

/**
 * Read the file under the given filepath into the given buffer
 * @param filepath Path to read from
 * @param buffer Buffer to fill with the data
 */
bool readFile(const std::string &filePath, std::vector<char> &buffer) {
    // Create the input file stream
    std::ifstream inputFile(filePath, std::ios::binary | std::ios::ate);

    // File error handling
    if (!inputFile) {
        std::cerr << "Failed to open input file" << std::endl;
        return false;
    }

    // Determine the size of the file
    std::streamsize fileSize = inputFile.tellg();

    // File size error handling
    if (fileSize < 0) {
        std::cerr << "Failed to determine file size" << std::endl;
        return false;
    }

    // Walk to the start of the file
    inputFile.seekg(0, std::ios::beg);
    // Resize the buffer
    buffer.resize(static_cast<size_t>(fileSize));

    // Read the file into the buffer
    if (fileSize > 0 && !inputFile.read(buffer.data(), fileSize)) {
        std::cerr << "Failed to read file" << std::endl;
        return false;
    }

    return true;
}

/**
 * Write the given buffer of the defined size to the given filepath
 * 
 */
bool writeFile(const std::string &filePath, std::vector<char> &buffer, int size) {
    // Creat the filestream of the file we want to write to
    std::ofstream outputFile(filePath, std::ios::binary);

    // Error handling
    if (!outputFile) {
        std::cerr << "Failed to open output file" << std::endl;
        return false;
    }

    // Write the buffer to the file
    outputFile.write(buffer.data(), size);

    return static_cast<bool>(outputFile);
}


int main(int argumentCount, char *argumentValues[]) {
    // Argument check
    if (argumentCount != 3) {
        std::cerr << "Usage: " << argumentValues[0] << " <input> <output>" << std::endl;
        return 1;
    }

    // Create the input buffer
    std::vector<char> inputBuffer;

    // Read the file found under the input file argument into the buffer
    if (!readFile(argumentValues[1], inputBuffer)) {
        return 1;
    }

    // Check that the buffer is not empty after reading
    if (inputBuffer.empty()) {
        std::cerr << "Input file is empty" << std::endl;
        return 1;
    }

    // Determine the size of the read data
    const int inputSize = static_cast<int>(inputBuffer.size());
    // Calculate the maximal size after compression
    const int maxCompressedSize = LZ4_compressBound(inputSize);

    // Create a new buffer for the compressed data
    std::vector<char> compressedBuffer(maxCompressedSize);

    // Perform the actual compression
    const int compressedSize = LZ4_compress_default(
        inputBuffer.data(),
        compressedBuffer.data(),
        inputSize,
        maxCompressedSize
    );

    // Check that the compression actually yielded valid output
    if (compressedSize <= 0) {
        std::cerr << "Compression failed" << std::endl;
        return 1;
    }

    // Write the compressed data to the given second file
    if (!writeFile(argumentValues[2], compressedBuffer, compressedSize)) {
        return 1;
    }

    std::cout << "Compressed " << inputSize
              << " bytes to " << compressedSize << " bytes\n";

    return 0;
}