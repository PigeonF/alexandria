#include <stdlib.h>

#include <adder/add.h>

void test_1_2() {
  if (adder_add(1, 2) != 3) {
    abort();
  }
}

int main(int argc, const char *argv[]) { test_1_2(); }
