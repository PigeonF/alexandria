#include <adder/add.h>

#include <iostream>

int main(int argc, const char *argv[]) {
  std::cout << "2 + 3 = " << adder_add(2, 3) << std::endl;
  return EXIT_SUCCESS;
}
