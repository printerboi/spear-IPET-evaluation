#include <stdio.h>
#include <tommath.h>

int main() {
    // Define the number
    mp_int primeNumber;
    bool isPrime = false;

    // Initialize all big integers
    if (mp_init_multi(&primeNumber, NULL) != MP_OKAY) {
        printf("Initialization failed\n");
        return 1;
    }

     // Set value
    mp_set_i32(&primeNumber, 713129);

    // Test if prime
    if (mp_prime_is_prime(&primeNumber, 4, &isPrime) != MP_OKAY) {
        printf("Primetest failed\n");
    }

    // Print results
    printf("Number: ");
    mp_fwrite(&primeNumber, 10, stdout);
    printf("\n");

    printf("Is this number a prime number?: %d", isPrime);
    printf("\n");

    return 0;
}