#include <sodium.h>
#include <iostream>
#include <vector>
#include <cstring>

// Generate deterministic pseudo-random data for reproducibility
void generateInputData(std::vector<unsigned char> &buffer, unsigned int seed) {
    for (size_t index = 0; index < buffer.size(); ++index) {
        buffer[index] = static_cast<unsigned char>((index * 131 + seed) % 256);
    }
}

int main() {
    if (sodium_init() < 0) {
        std::cerr << "Failed to initialize libsodium\n";
        return 1;
    }

    // Different message sizes to exercise different code paths
    std::vector<size_t> messageSizes = {
        64,        // small
        1024,      // medium
        16 * 1024, // larger
        256 * 1024 // large
    };

    const int iterationsPerSize = 1000;

    for (size_t sizeIndex = 0; sizeIndex < messageSizes.size(); ++sizeIndex) {
        size_t messageSize = messageSizes[sizeIndex];

        std::vector<unsigned char> messageBuffer(messageSize);
        generateInputData(messageBuffer, static_cast<unsigned int>(sizeIndex));

        std::vector<unsigned char> hashOutput(crypto_generichash_BYTES);

        for (int iteration = 0; iteration < iterationsPerSize; ++iteration) {
            // Slightly modify input to avoid identical runs
            messageBuffer[iteration % messageBuffer.size()] ^= static_cast<unsigned char>(iteration);

            if (crypto_generichash(
                    hashOutput.data(),
                    hashOutput.size(),
                    messageBuffer.data(),
                    messageBuffer.size(),
                    nullptr,
                    0) != 0) {

                std::cerr << "Hashing failed\n";
                return 1;
            }
        }

        std::cout << "Processed message size: " << messageSize << " bytes\n";
    }

    return 0;
}