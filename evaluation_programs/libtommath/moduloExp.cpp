#include <stdio.h>
#include <tommath.h>

/**
 * Calculate a + (b * c)
 * 
 */
int main() {
    // Define the numbers
    mp_int base;
    mp_int exponent;
    mp_int mod;

    // Define the result
    mp_int result;

    // Initialize all big integers
    if (mp_init_multi(&base, &exponent, &mod, &result, NULL) != MP_OKAY) {
        printf("Initialization failed\n");
        return 1;
    }

     // Set values
    mp_set_i32(&base, 7);
    mp_set_i32(&exponent, 128);
    mp_set_i32(&mod, 13);

    // multiplicationResult = secondNumber * thirdNumber
    if (mp_exptmod(&base, &exponent, &mod, &result) != MP_OKAY) {
        printf("Calculation failed\n");
    }

    // Print result
    printf("Result: ");
    mp_fwrite(&result, 10, stdout);
    printf("\n");

    return 0;
}