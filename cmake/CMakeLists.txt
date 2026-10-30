cmake_minimum_required(VERSION 4.4 FATAL_ERROR)

project(
    cmake-tests
    LANGUAGES NONE
)

enable_testing()

add_test(
    NAME adder
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/adder" "${PROJECT_BINARY_DIR}/adder"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            "--presets-file=${PROJECT_SOURCE_DIR}/adder/CMakePresets.json"
            --preset=default
        --test-command "${CMAKE_CTEST_COMMAND}"
)
