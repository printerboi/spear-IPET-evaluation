/*
 * Decryption with fixed key and embedded ciphertext (DEMO ONLY)
 */

#include <sodium.h>

#include <cstring>
#include <iostream>
#include <string>
#include <vector>

/**
 * Convert a given string to binary data in form of a vector
 * @param data String data to convert
 * @return Binary data as vector
 * 
 */
std::vector<unsigned char> hexToBytes(const std::string &hexString) {
    // Create a dynamic variable where we will store the data
    std::vector<unsigned char> output;
    output.reserve(hexString.length() / 2);

    // Iterate over the input
    for (std::size_t index = 0; index < hexString.length(); index += 2) {
        // Convert the string to binary data
        std::string byteString = hexString.substr(index, 2);
        unsigned char byte = static_cast<unsigned char>(std::stoul(byteString, nullptr, 16));
        output.push_back(byte);
    }

    // Return the generated output
    return output;
}

int main() {
    // Init sodium algos
    if (sodium_init() < 0) {
        std::cerr << "libsodium init failed\n";
        return 1;
    }

    // Key we want to use for decryption
    unsigned char encryptionKey[crypto_aead_xchacha20poly1305_ietf_KEYBYTES] = {
        0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
        0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
        0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,
        0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F
    };

    // Some ciphertext we want to decrypt
    const std::string inputHex = "d15da50c6cbda39d1895ac8609535d2116fd444d3efa8323f15558634357da3bebf45bfb650058b460ce9f53deda836269a81fe94e108f126f4863efed009569bf8eb72bde30baec";

    // Convert the cyphertext to binary
    std::vector<unsigned char> inputBytes = hexToBytes(inputHex);

    if (inputBytes.size() < crypto_aead_xchacha20poly1305_ietf_NPUBBYTES) {
        std::cerr << "Input too short\n";
        return 1;
    }

    // Read the nonce from the parsed ciphertext
    unsigned char nonce[crypto_aead_xchacha20poly1305_ietf_NPUBBYTES];
    std::memcpy(nonce, inputBytes.data(), sizeof(nonce));

    // Extract the ciphertext
    std::vector<unsigned char> ciphertext(
        inputBytes.begin() + sizeof(nonce),
        inputBytes.end()
    );

    // Reserve space for the decrypted string
    std::vector<unsigned char> decrypted(ciphertext.size());
    unsigned long long decryptedLength = 0;

    // Perfrom decryption
    if (crypto_aead_xchacha20poly1305_ietf_decrypt(
            decrypted.data(),
            &decryptedLength,
            nullptr,
            ciphertext.data(),
            ciphertext.size(),
            nullptr,
            0,
            nonce,
            encryptionKey) != 0) {
        std::cerr << "Decryption failed (wrong key / tampered data)\n";
        return 1;
    }

    decrypted.resize(static_cast<std::size_t>(decryptedLength));

    // Output handling
    std::cout << "Decrypted text:\n";
    std::cout << std::string(decrypted.begin(), decrypted.end()) << "\n";

    return 0;
}