/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include "sodium.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argumentCount, char *argumentValues[]) {
    // Check if all arguments are provided
    if(argumentCount != 3) {
        printf("Usage: %s <input> <output>\n", argumentValues[0]);
        return 1;
    }

    // Init sodium
    if(sodium_init() < 0) {
        perror("Sodium could not be initialized!");
        return 1;
    }

    const char *inputfilepath = argumentValues[1];
    const char *outputfilepath = argumentValues[2];

    // Open the inputfile
    FILE *inputFile = fopen(inputfilepath, "rb");
    if(!inputFile) {
        perror("Failed to open the input file!");
        return 1;
    }

    // Determine the file size
    fseek(inputFile, 0, SEEK_END);
    long inputSize = ftell(inputFile);
    rewind(inputFile);

    // Create a input buffer
    unsigned char *inputBuffer = (unsigned char *) malloc(inputSize);

    // Read the file into the buffer
    fread(inputBuffer, 1, inputSize, inputFile);
    fclose(inputFile);

    
    // Create a buffer for the output data
    unsigned char *cipherBuffer = (unsigned char *) malloc(inputSize + crypto_secretbox_MACBYTES);

    // Create arrays for the key and the nonce
    unsigned char key[crypto_secretbox_KEYBYTES];
    unsigned char nonce[crypto_secretbox_NONCEBYTES];

    // Fill the key and the nonce
    randombytes_buf(key, sizeof key);
    randombytes_buf(nonce, sizeof nonce);

    // Call the encryption
    crypto_secretbox_easy(cipherBuffer, inputBuffer, inputSize, nonce, key);

    // Create the output file and write the encrypted data into it
    FILE *outputfile = fopen(outputfilepath, "wb");
    fwrite(cipherBuffer, 1, inputSize + crypto_secretbox_MACBYTES, outputfile);
    fclose(outputfile);

    
    // Free the memory
    free(inputBuffer);
    free(cipherBuffer);
    return 0;
}