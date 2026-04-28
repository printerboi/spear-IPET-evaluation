#include <lz4.h>

#include <cstring>
#include <iostream>
#include <vector>

int main() {
    const int inputSize = 16 * 1024;

    std::vector<char> originalBuffer(inputSize);
    for (int byteIndex = 0; byteIndex < inputSize; ++byteIndex) {
        originalBuffer[byteIndex] = static_cast<char>('A' + (byteIndex % 4));
    }

    const int maximumCompressedSize = LZ4_compressBound(inputSize);
    std::vector<char> compressedBuffer(maximumCompressedSize);

    const int compressedSize = LZ4_compress_default(
        originalBuffer.data(),
        compressedBuffer.data(),
        inputSize,
        maximumCompressedSize
    );

    if (compressedSize <= 0) {
        std::cerr << "LZ4_compress_default failed\n";
        return 1;
    }

    std::vector<char> decompressedBuffer(inputSize);

    const int decompressedSize = LZ4_decompress_safe(
        compressedBuffer.data(),
        decompressedBuffer.data(),
        compressedSize,
        inputSize
    );

    if (decompressedSize < 0) {
        std::cerr << "LZ4_decompress_safe failed\n";
        return 1;
    }

    if (decompressedSize != inputSize) {
        std::cerr << "Unexpected decompressed size\n";
        return 1;
    }

    std::cout << "Compressed size: " << compressedSize << "\n";
    std::cout << "Decompressed size: " << decompressedSize << "\n";

    return 0;
}