/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include "sodium.h"

#include <iostream>
#include <string>
#include <vector>

int main() {
    // init sodium
    if (sodium_init() < 0) {
        std::cout << "Failed to initialize Sodium!" << std::endl;
        return 1;
    }

    // Define a fixed message
    const std::string message = "I need to be encrypted asymentrically!";

    // Create a message buffer
    std::vector<unsigned char> messageBuffer(message.begin(), message.end());

    // Generate a authentication key
    std::vector<unsigned char> key(crypto_auth_KEYBYTES);
    crypto_auth_keygen(key.data());

    // Create a MAC buffer
    std::vector<unsigned char> macBuffer(crypto_auth_BYTES);

    // Generate the actual mac
    crypto_auth(
        macBuffer.data(),
        messageBuffer.data(),
        messageBuffer.size(),
        key.data()
    );

    // Verify the mac
    int validationResult = crypto_auth_verify(
        macBuffer.data(),
        messageBuffer.data(),
        messageBuffer.size(),
        key.data()
    );

    // Error handling
    if (validationResult != 0) {
        std::cout << "Auth verification failed!" << std::endl;
        return 1;
    }

    std::cout << "Valid MAC verification succeeded" << std::endl;

    return 0;
}