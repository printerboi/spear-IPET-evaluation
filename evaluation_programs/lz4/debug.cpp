#include <iostream>

static int doExpensiveWork(int value) {
    int result = value;

    result = result * 3 + 1;
    result = result ^ 0x55;
    result = result + 17;

    return result;
}

static int innerLoop(int startValue) {
    int value = startValue;

    // Inner loop bound: UB = 5
    for (int innerIndex = 0; innerIndex < 5; innerIndex++) {
        value = doExpensiveWork(value);
    }

    return value;
}

static int outerLoopCallsInnerLoopMultipleTimes() {
    int value = 1;

    // Outer loop bound: UB = 4
    for (int outerIndex = 0; outerIndex < 4; outerIndex++) {
        value += innerLoop(value);
    }

    return value;
}

int main() {
    int result = outerLoopCallsInnerLoopMultipleTimes();

    std::cout << "Result: " << result << "\n";

    return 0;
}