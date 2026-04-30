#include <lz4.h>

#include <iostream>
#include <string>
#include <vector>

int main() {
    // Create the dictionary string
    const std::string dictionaryText =
        "GET /api/user HTTP/1.1\r\n"
        "Host: example.com\r\n"
        "User-Agent: benchmark-client\r\n"
        "Accept: application/json\r\n"
        "Content-Type: application/json\r\n";

        // Create the actual string to compress
    const std::string messageText =
        "GET /api/user HTTP/1.1\r\n"
        "Host: example.com\r\n"
        "User-Agent: benchmark-client\r\n"
        "Accept: application/json\r\n"
        "Content-Type: application/json\r\n"
        "{\"id\":42,\"name\":\"Alice\",\"role\":\"admin\",\"active\":true}";

    // Create a buffer for the dictionary
    std::vector<char> dictionaryBuffer(dictionaryText.begin(), dictionaryText.end());
    // Create a buffer for the input string
    std::vector<char> inputBuffer(messageText.begin(), messageText.end());

    // Determine sizes of the data inside the buffer an after compression
    const int inputSize = static_cast<int>(inputBuffer.size());
    const int dictionarySize = static_cast<int>(dictionaryBuffer.size());
    const int maxCompressedSize = LZ4_compressBound(inputSize);

    // Create a buffer for the compressed data
    std::vector<char> compressedBuffer(maxCompressedSize);

    // Create a compression stream
    LZ4_stream_t *compressionStream = LZ4_createStream();

    // Validate taht the compression strema could be opnened
    if (compressionStream == nullptr) {
        std::cerr << "Failed to create LZ4 stream" << std::endl;
        return 1;
    }

    // Load our dictionary
    const int loadedDictionarySize = LZ4_loadDict(
        compressionStream,
        dictionaryBuffer.data(),
        dictionarySize
    );

    // Validate that the loading of the dictionary was successfull
    if (loadedDictionarySize <= 0) {
        // Make sure that we free the compression stream in an error case
        LZ4_freeStream(compressionStream);
        std::cerr << "Failed to load dictionary" << std::endl;
        return 1;
    }

    // Perform the compression inside the stream
    const int compressedSize = LZ4_compress_fast_continue(
        compressionStream,
        inputBuffer.data(),
        compressedBuffer.data(),
        inputSize,
        maxCompressedSize,
        1
    );

    // Free the stream after the compression
    LZ4_freeStream(compressionStream);

    // Validate that the compression was successfull
    if (compressedSize <= 0) {
        std::cerr << "Dictionary compression failed" << std::endl;
        return 1;
    }

    std::cout << "Dictionary compressed " << inputSize
              << " bytes to " << compressedSize << " bytes\n";

    return 0;
}