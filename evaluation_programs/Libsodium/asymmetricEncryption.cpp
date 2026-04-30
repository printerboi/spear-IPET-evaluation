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

    // Create a buffer for the message
    std::vector<unsigned char> messageBuffer(message.begin(), message.end());

    // Define key pair buffers
    std::vector<unsigned char> senderPublicKey(crypto_box_PUBLICKEYBYTES);
    std::vector<unsigned char> senderSecretKey(crypto_box_SECRETKEYBYTES);
    std::vector<unsigned char> receiverPublicKey(crypto_box_PUBLICKEYBYTES);
    std::vector<unsigned char> receiverSecretKey(crypto_box_SECRETKEYBYTES);

    // Generate the keys
    crypto_box_keypair(senderPublicKey.data(), senderSecretKey.data());
    crypto_box_keypair(receiverPublicKey.data(), receiverSecretKey.data());

    // Create a nonce and fill it with random bytes
    std::vector<unsigned char> nonce(crypto_box_NONCEBYTES);
    randombytes_buf(nonce.data(), nonce.size());

    // Create buffers for the cyphertext and decrypted message
    std::vector<unsigned char> cipherBuffer(messageBuffer.size() + crypto_box_MACBYTES);
    std::vector<unsigned char> decryptedBuffer(messageBuffer.size());

    // Encrypt the message
    int encryptResult = crypto_box_easy(
        cipherBuffer.data(),
        messageBuffer.data(),
        messageBuffer.size(),
        nonce.data(),
        receiverPublicKey.data(),
        senderSecretKey.data());

    // Error handling
    if (encryptResult != 0) {
        std::cerr << "Failed to encrypt the message!" << std::endl;
        return 1;
    }

    // Decrypt the cyphertext again
    int decryptResult = crypto_box_open_easy(
        decryptedBuffer.data(),
        cipherBuffer.data(),
        cipherBuffer.size(),
        nonce.data(),
        senderPublicKey.data(),
        receiverSecretKey.data());

    // Error handling
    if (decryptResult != 0) {
        std::cerr << "Decryption failed" << std::endl;
        return 1;
    }


    // Check if both messages match
    bool messageMatches = true;

    for (size_t byteIndex = 0; byteIndex < messageBuffer.size(); ++byteIndex) {
        if (messageBuffer[byteIndex] != decryptedBuffer[byteIndex]) {
            messageMatches = false;
            break;
        }
    }

    if (!messageMatches) {
        std::cerr << "Message mismatch" << std::endl;
        return 1;
    }

    std::cout << "Messages match!" << std::endl;
    std::cout << "Finished asymmetric encryption" << std::endl;

    return 0;
}