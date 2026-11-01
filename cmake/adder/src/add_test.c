#include <stdlib.h>

#include <adder/add.h>

void test_2_2() {
  if (adder_add(2, 2) != 4) {
    abort();
  }
}

int main(int argc, const char *argv[]) { test_2_2(); }
