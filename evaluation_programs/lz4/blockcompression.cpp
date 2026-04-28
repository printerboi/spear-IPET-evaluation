#include <lz4.h>

#include <cstring>
#include <iostream>
#include <vector>

int main() {
    const int inputSize = 16 * 1024;

    std::vector<char> inputBuffer(inputSize);
    for (int byteIndex = 0; byteIndex < inputSize; ++byteIndex) {
        inputBuffer[byteIndex] = static_cast<char>('A' + (byteIndex % 4));
    }

    const int maximumCompressedSize = LZ4_compressBound(inputSize);
    std::vector<char> compressedBuffer(maximumCompressedSize);

    const int compressedSize = LZ4_compress_default(
        inputBuffer.data(),
        compressedBuffer.data(),
        inputSize,
        maximumCompressedSize
    );

    if (compressedSize <= 0) {
        std::cerr << "LZ4_compress_default failed\n";
        return 1;
    }

    std::cout << "Input size: " << inputSize << "\n";
    std::cout << "Compressed size: " << compressedSize << "\n";

    return 0;
}