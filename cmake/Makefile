.POSIX:

CC = clang
CXX = clang++

.PHONY: default
defualt: test

.PHONY: configure
configure:
	cmake -E env CC="$(CC)" CXX="$(CXX)" cmake -S adder -B build -G "Ninja Multi-Config" -D BUILD_SHARED_LIBS=ON --presets-file=adder/CMakePresets.json --preset=default

.PHONY: configure-e2e
configure-e2e:
	cmake -E env CC="$(CC)" CXX="$(CXX)" cmake -S . -B build-e2e -G "Ninja Multi-Config"

.PHONY: test-e2e
test-e2e:
	ctest --test-dir build-e2e -C Debug --verbose

.PHONY: test
test:
	cmake -E env CC="$(CC)" CXX="$(CXX)" ctest --build-and-test . build-test --build-generator "Ninja Multi-Config" -C Debug   --test-command ctest -C Debug   --output-on-failure
	cmake -E env CC="$(CC)" CXX="$(CXX)" ctest --build-and-test . build-test --build-generator "Ninja Multi-Config" -C Release --test-command ctest -C Release --output-on-failure
