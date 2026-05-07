#include <stdio.h>
#include <tommath.h>

int main() {
    // RSA calculation atomics
    mp_int publicExponent;
    mp_int p;
    mp_int q;

    // Message
    mp_int message;

    // Result containers
    mp_int N;
    mp_int phi;
    mp_int privateExponent;
    mp_int pMinus;
    mp_int qMinus;
    mp_int encrypted;
    mp_int decrypted;

    // Initialize all big integers
    if (mp_init_multi(&publicExponent, &p, &q, &message, &N, &encrypted, &decrypted, &phi, &privateExponent, &pMinus, &qMinus, NULL) != MP_OKAY) {
        printf("Initialization failed\n");
        return 1;
    }

    // Set Numbers
    mp_set_i32(&p, 61);
    mp_set_i32(&q, 53);
    mp_set_i32(&publicExponent, 17);
    mp_set_i32(&message, 65);

    // Calculate N
    if (mp_mul(&p, &q, &N) != MP_OKAY) {
        printf("Multiplikation of N failed\n");
    }

    /* if () {
        printf("Multiplikation of N failed\n");
    } */

    // Calculate (p - 1)
    if (mp_sub_d(&p, 1, &pMinus) != MP_OKAY) {
        printf("p - 1 failed\n");
    }

    // Calculate (q - 1)
    if (mp_sub_d(&q, 1, &qMinus) != MP_OKAY) {
        printf("q - 1 failed\n");
    }

    // Calculate phi
    if (mp_mul(&pMinus, &qMinus, &phi) != MP_OKAY) {
        printf("phi failed\n");
    }

    // Calculate private exponent d = e^-1 mod phi
    if (mp_invmod(&publicExponent, &phi, &privateExponent) != MP_OKAY) {
        printf("private exponent failed\n");
    }

    // Encrypt message
    if (mp_exptmod(&message, &publicExponent, &N, &encrypted) != MP_OKAY) {
        printf("Encryption failed\n");
    }

    // Dencrypt message
    if (mp_exptmod(&encrypted, &privateExponent, &N, &decrypted) != MP_OKAY) {
        printf("Decryption failed\n");
    }

    printf("n = ");
    mp_fwrite(&N, 10, stdout);
    printf("\n");

    printf("phi(n) = ");
    mp_fwrite(&phi, 10, stdout);
    printf("\n");

    printf("d = ");
    mp_fwrite(&privateExponent, 10, stdout);
    printf("\n");

    printf("message = ");
    mp_fwrite(&message, 10, stdout);
    printf("\n");

    printf("encrypted = ");
    mp_fwrite(&encrypted, 10, stdout);
    printf("\n");

    printf("decrypted = ");
    mp_fwrite(&decrypted, 10, stdout);
    printf("\n");

    return 0;
}