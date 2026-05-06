#include <stdio.h>
#include <tommath.h>

int main() {
    // Define the numbers
    mp_int a;
    mp_int b;

    // Define result containers
    mp_int gcd;
    

    // Initialize all big integers
    if (mp_init_multi(&a, &b, &gcd, NULL) != MP_OKAY) {
        printf("Initialization failed\n");
        return 1;
    }

     // Set value
    mp_set_i32(&a, 738);
    mp_set_i32(&b, 17);

    // Calculate gcd
    if (mp_gcd(&a, &b, &gcd) != MP_OKAY) {
        printf("GCD failed\n");
    }

    // Print results
    printf("GCD(");
    mp_fwrite(&a, 10, stdout);
    printf(",");
    mp_fwrite(&b, 10, stdout);
    printf(") = ");
    mp_fwrite(&gcd, 10, stdout);
    printf("\n");

    return 0;
}