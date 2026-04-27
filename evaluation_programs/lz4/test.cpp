#include <cstring>
#include <iostream>
#include <string>
#include <vector>

#include <lz4.h>

int main() {
    const std::string inputText =
        "LZ4 is a fast compression algorithm. "
        "This example compresses and decompresses a repeated text block. "
        "LZ4 is a fast compression algorithm. "
        "This example compresses and decompresses a repeated text block. "
        "LZ4 is a fast compression algorithm. "
        "This example compresses and decompresses a repeated text block.";

    const int inputSize = static_cast<int>(inputText.size());
    const int maximumCompressedSize = LZ4_compressBound(inputSize);

    std::vector<char> compressedBuffer(static_cast<std::size_t>(maximumCompressedSize));
    std::vector<char> decompressedBuffer(static_cast<std::size_t>(inputSize));

    const int compressedSize = LZ4_compress_default(
        inputText.data(),
        compressedBuffer.data(),
        inputSize,
        maximumCompressedSize
    );

    if (compressedSize <= 0) {
        std::cerr << "Compression failed\n";
        return 1;
    }

    const int decompressedSize = LZ4_decompress_safe(
        compressedBuffer.data(),
        decompressedBuffer.data(),
        compressedSize,
        inputSize
    );

    if (decompressedSize < 0) {
        std::cerr << "Decompression failed\n";
        return 1;
    }

    const bool outputMatchesInput =
        decompressedSize == inputSize &&
        std::memcmp(inputText.data(), decompressedBuffer.data(), static_cast<std::size_t>(inputSize)) == 0;

    if (!outputMatchesInput) {
        std::cerr << "Roundtrip mismatch\n";
        return 1;
    }

    std::cout << "Original size: " << inputSize << "\n";
    std::cout << "Compressed size: " << compressedSize << "\n";
    std::cout << "Decompressed size: " << decompressedSize << "\n";

    return 0;
}