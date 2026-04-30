/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include "sodium.h"
#include <iostream>
#include <vector>
#include <string>

int main() {
    // Init sodium
    if(sodium_init() < 0) {
        std::cout << "Failed to initialize Sodium!" << std::endl;
        return 1;
    }

    // Define a fixed message
    const std::string message = "This is a string that we want to sign!";

    // Create a buffer for the message
    std::vector<unsigned char> messageBuffer(message.begin(), message.end());

    // Generate key pair
    std::vector<unsigned char> publicKey(crypto_sign_PUBLICKEYBYTES);
    std::vector<unsigned char> secretKey(crypto_sign_SECRETKEYBYTES);

    crypto_sign_keypair(publicKey.data(), secretKey.data());

    // Create a signature
    std::vector<unsigned char> signature(crypto_sign_BYTES);

    // Sign the message
    crypto_sign_detached(signature.data(), nullptr, messageBuffer.data(), messageBuffer.size(), secretKey.data());

    // Verify the signature
    int verifyResult = crypto_sign_verify_detached(signature.data(), messageBuffer.data(), messageBuffer.size(), publicKey.data());

    if (verifyResult != 0) {
        std::cout << "Verification failed\n";
        return 1;
    }

    std::cout << "Verification succeeded\n";
    return 0;
}