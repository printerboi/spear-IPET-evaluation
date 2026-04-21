#include <sodium.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef MESSAGE_LENGTH
#define MESSAGE_LENGTH 4096
#endif

#ifndef NUMBER_OF_ITERATIONS
#define NUMBER_OF_ITERATIONS 10000
#endif

static void initialize_message(unsigned char *message, size_t message_length) {
    for (size_t index = 0; index < message_length; ++index) {
        message[index] = (unsigned char)(index & 0xFF);
    }
}

int main(void) {
    if (sodium_init() < 0) {
        fprintf(stderr, "libsodium initialization failed\n");
        return 1;
    }

    unsigned char key[crypto_secretbox_KEYBYTES];
    unsigned char nonce[crypto_secretbox_NONCEBYTES];

    memset(key, 0x11, sizeof(key));
    memset(nonce, 0x22, sizeof(nonce));

    unsigned char *message = (unsigned char *)malloc(MESSAGE_LENGTH);
    unsigned char *ciphertext =
        (unsigned char *)malloc(MESSAGE_LENGTH + crypto_secretbox_MACBYTES);

    if (message == NULL || ciphertext == NULL) {
        fprintf(stderr, "memory allocation failed\n");
        free(message);
        free(ciphertext);
        return 1;
    }

    initialize_message(message, MESSAGE_LENGTH);

    uint64_t checksum = 0;

    for (int iteration = 0; iteration < NUMBER_OF_ITERATIONS; ++iteration) {
        if (crypto_secretbox_easy(
                ciphertext,
                message,
                MESSAGE_LENGTH,
                nonce,
                key) != 0) {
            fprintf(stderr, "encryption failed\n");
            free(message);
            free(ciphertext);
            return 1;
        }

        checksum += ciphertext[iteration % (MESSAGE_LENGTH + crypto_secretbox_MACBYTES)];
    }

    printf("checksum=%llu\n", (unsigned long long)checksum);

    free(message);
    free(ciphertext);
    return 0;
}