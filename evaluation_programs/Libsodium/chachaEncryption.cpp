/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <sodium.h>

#include <iomanip>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <cstring>

/**
 * Convert given binary data with fixed length to a string
 * @param data Binary data to convert
 * @param length Length of the data to convert
 * @return Hex representation of the given data as string
 * 
 */
std::string bytesToHex(const unsigned char *data, std::size_t length) {
    // Define the outputstream
    std::ostringstream outputStream;

    // Iterate over the data
    for (std::size_t index = 0; index < length; ++index) {
        outputStream << std::hex << std::setw(2) << std::setfill('0')
                     << static_cast<int>(data[index]);
    }

    // Convert the outputstream to a string
    return outputStream.str();
}

int main() {
    // Init sodium algos
    if (sodium_init() < 0) {
        std::cerr << "libsodium init failed\n";
        return 1;
    }

    // Define the plaintext we want to encrypt
    const std::string plaintext = "Hello this is a text that should be encrypted";

    // Key we want to use for encryption
    unsigned char encryptionKey[crypto_aead_xchacha20poly1305_ietf_KEYBYTES] = {
        0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
        0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
        0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,
        0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F
    };

    // Generate a random nonce
    unsigned char nonce[crypto_aead_xchacha20poly1305_ietf_NPUBBYTES];
    randombytes_buf(nonce, sizeof(nonce));

    // Reserve space for the ciphertext
    std::vector<unsigned char> ciphertext(plaintext.size() + crypto_aead_xchacha20poly1305_ietf_ABYTES);

    unsigned long long ciphertextLength = 0;

    // Run the encryption
    crypto_aead_xchacha20poly1305_ietf_encrypt(
        ciphertext.data(),
        &ciphertextLength,
        reinterpret_cast<const unsigned char *>(plaintext.data()),
        plaintext.size(),
        nullptr,
        0,
        nullptr,
        nonce,
        encryptionKey
    );

    ciphertext.resize(static_cast<std::size_t>(ciphertextLength));

    // Convert the generated binary data to hex strings
    std::string nonceHex = bytesToHex(nonce, sizeof(nonce));
    std::string cipherHex = bytesToHex(ciphertext.data(), ciphertext.size());

    // Output nonce and ciphertext
    std::cout << nonceHex + cipherHex << "\n";

    return 0;
}