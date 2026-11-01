cmake_minimum_required(VERSION 4.4 FATAL_ERROR)

project(
    cmake-tests
    LANGUAGES NONE
)

enable_testing()

# Build & Install (separate build trees, combined install tree)
#   - shared + static

add_test(
    NAME adder.shared
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/adder" "${PROJECT_BINARY_DIR}/adder"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            "--presets-file=${PROJECT_SOURCE_DIR}/adder/CMakePresets.json"
            --preset=default
            -D "CMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/install/adder"
            -D "BUILD_SHARED_LIBS=ON"
        --build-target install
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME adder.static
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/adder" "${PROJECT_BINARY_DIR}/adder"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            "--presets-file=${PROJECT_SOURCE_DIR}/adder/CMakePresets.json"
            --preset=default
            "-DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/install/adder"
        --build-target install
        --test-command "${CMAKE_CTEST_COMMAND}"
)

# find_package
#   - add_subdirectory + reference binary dir + install dir + FetchContent
#   - shared + static

# pkgconfig

# CPS
