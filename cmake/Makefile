.POSIX:

CC = clang
CXX = clang++

.PHONY: default
defualt: test

.PHONY: configure
configure:
	cmake -E env CC="$(CC)" CXX="$(CXX)" cmake -S adder -B build -G "Ninja Multi-Config" -D BUILD_SHARED_LIBS=ON --presets-file=adder/CMakePresets.json --preset=default

.PHONY: test
test:
	cmake -E env CC="$(CC)" CXX="$(CXX)" ctest --build-and-test . build-e2e --build-generator Ninja --test-command ctest --output-on-failure --verbose
