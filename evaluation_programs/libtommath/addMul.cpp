#include <stdio.h>
#include <tommath.h>

/**
 * Calculate a + (b * c)
 * 
 */
int main() {
    // Define the numbers
    mp_int first;
    mp_int second;
    mp_int third;

    // Define the results
    mp_int multiplication;
    mp_int result;

    // Initialize all big integers
    if (mp_init_multi(&first, &second, &third, &multiplication, &result, NULL) != MP_OKAY) {
        printf("Initialization failed\n");
        return 1;
    }

     // Set values
    mp_set_i32(&first, 8889);
    mp_set_i32(&second, 230045);
    mp_set_i32(&third, 643);

    // multiplicationResult = secondNumber * thirdNumber
    if (mp_mul(&second, &third, &multiplication) != MP_OKAY) {
        printf("Multiplication failed\n");
    }

    // finalResult = firstNumber + multiplicationResult
    if (mp_add(&first, &multiplication, &result) != MP_OKAY) {
        printf("Addition failed\n");
    }

    // Print result
    printf("Result: ");
    mp_fwrite(&result, 10, stdout);
    printf("\n");

    return 0;
}