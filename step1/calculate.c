#include <stdio.h>
#include <stdlib.h>
#include <emscripten.h>

int sum(int a, int b) {
    return a + b;
}
int main() {
    int a = 1;
    int b = 4;
    printf("The sum of %d and %d is %d\n", a, b, sum(a, b));
    return 0;
}