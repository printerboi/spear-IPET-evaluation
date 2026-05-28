/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include "sodium.h"
#include <iostream>
#include <vector>

int main() {
    // Init sodium
    if(sodium_init() < 0) {
        std::cout << "Failed to initialize Sodium!" << std::endl;
        return 1;
    }

    // Generate Client key buffers
    std::vector<unsigned char> clientPublicKey(crypto_kx_PUBLICKEYBYTES);
    std::vector<unsigned char> clientSecretKey(crypto_kx_SECRETKEYBYTES);

    // Generate Server key buffers
    std::vector<unsigned char> serverPublicKey(crypto_kx_PUBLICKEYBYTES);
    std::vector<unsigned char> serverSecretKey(crypto_kx_SECRETKEYBYTES);

    // Fill the key buffers
    crypto_kx_keypair(clientPublicKey.data(), clientSecretKey.data());
    crypto_kx_keypair(serverPublicKey.data(), serverSecretKey.data());


    // Create buffers for shared keys
    std::vector<unsigned char> clientRx(crypto_kx_SESSIONKEYBYTES);
    std::vector<unsigned char> clientTx(crypto_kx_SESSIONKEYBYTES);

    std::vector<unsigned char> serverRx(crypto_kx_SESSIONKEYBYTES);
    std::vector<unsigned char> serverTx(crypto_kx_SESSIONKEYBYTES);

    // Perform the actual key exchange
    int clientExchangeResult = crypto_kx_client_session_keys(
        clientRx.data(),
        clientTx.data(),
        clientPublicKey.data(),
        clientSecretKey.data(),
        serverPublicKey.data()
    );

    int serverExchangeResult = crypto_kx_server_session_keys(
        serverRx.data(),
        serverTx.data(),
        serverPublicKey.data(),
        serverSecretKey.data(),
        clientPublicKey.data()
    );

    // Verify the sucess of the key exchange
    if (clientExchangeResult != 0 || serverExchangeResult != 0) {
        std::cerr << "Key exchange fialed!\n" << std::endl;
        return 1;
    }

    // Validate that both sides derived valid keys
    bool keysMatch = true;
    for(size_t i=0; i < crypto_kx_SESSIONKEYBYTES; i++) {
        if(clientTx[i] != serverRx[i] || clientRx[i] != serverTx[i]) {
            keysMatch = false;
            break;
        }
    }

    if (!keysMatch) {
        std::cerr << "Keys do not match! Error!" << std::endl;
        return 1;
    }

    

    std::cout << "Key exchange successfull!" << std::endl;
    
    return 0;
}