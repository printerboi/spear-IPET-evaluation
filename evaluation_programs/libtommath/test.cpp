#include <tommath.h>

#include <iostream>

int main() {
    mp_int firstNumber;
    mp_int secondNumber;
    mp_int result;

    if (mp_init_multi(&firstNumber, &secondNumber, &result, nullptr) != MP_OKAY) {
        std::cerr << "Failed to initialize LibTomMath integers\n";
        return 1;
    }

    if (mp_read_radix(
            &firstNumber,
            "1234567890123456789012345678901234567890123456789012345678901234567890",
            10
        ) != MP_OKAY) {
        std::cerr << "Failed to read first number\n";
        mp_clear_multi(&firstNumber, &secondNumber, &result, nullptr);
        return 1;
    }

    if (mp_read_radix(
            &secondNumber,
            "9876543210987654321098765432109876543210987654321098765432109876543210",
            10
        ) != MP_OKAY) {
        std::cerr << "Failed to read second number\n";
        mp_clear_multi(&firstNumber, &secondNumber, &result, nullptr);
        return 1;
    }

    if (mp_mul(&firstNumber, &secondNumber, &result) != MP_OKAY) {
        std::cerr << "Multiplication failed\n";
        mp_clear_multi(&firstNumber, &secondNumber, &result, nullptr);
        return 1;
    }

    char resultBuffer[512];

    if (mp_to_radix(&result, resultBuffer, sizeof(resultBuffer), nullptr, 10) != MP_OKAY) {
        std::cerr << "Failed to convert result\n";
        mp_clear_multi(&firstNumber, &secondNumber, &result, nullptr);
        return 1;
    }

    std::cout << "Result: " << resultBuffer << "\n";

    mp_clear_multi(&firstNumber, &secondNumber, &result, nullptr);
    return 0;
}