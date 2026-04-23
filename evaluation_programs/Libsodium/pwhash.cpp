/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <sodium.h>

#include <iomanip>
#include <iostream>
#include <string>

/**
 * Print the given binary data as hex string
 * @param label Preceeding label
 * @param data Binary data to print
 * @param length Length of the data that will be printed
 * 
 */
void printHex(const std::string &label, const unsigned char *data, std::size_t length) {
    // Print the tabel
    std::cout << label;

    // Iterate over the binary data
    for (std::size_t index = 0; index < length; ++index) {
        std::cout << std::hex << std::setw(2) << std::setfill('0')
                  << static_cast<int>(data[index]);
    }

    // Reverse the output mode back to decimal
    std::cout << std::dec << '\n';
}

int main() {
    // Init sodium algos
    if (sodium_init() < 0) {
        std::cerr << "libsodium init failed\n";
        return 1;
    }

    // Our fixed password
    const std::string password = "benchmark-password";

    // Some random salt
    unsigned char salt[crypto_pwhash_SALTBYTES] = {
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
        0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F
    };

    // Variable where we want to store the resulting hash
    unsigned char hash[32];

    // Hash the password
    if (crypto_pwhash(
            hash,
            sizeof(hash),
            password.c_str(),
            password.size(),
            salt,
            crypto_pwhash_OPSLIMIT_MODERATE,
            crypto_pwhash_MEMLIMIT_MODERATE,
            crypto_pwhash_ALG_DEFAULT) != 0) {
        std::cerr << "crypto_pwhash failed (possibly out of memory)\n";
        return 1;
    }

    // Print the generated hash
    printHex("Derived key: ", hash, sizeof(hash));

    // Clear sodiums storage
    sodium_memzero(hash, sizeof(hash));
    return 0;
}