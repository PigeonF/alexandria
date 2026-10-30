cmake_minimum_required(VERSION 4.4 FATAL_ERROR)

project(
    cmake-tests
    LANGUAGES C
)

enable_testing()

add_test(
    NAME test
    COMMAND "${CMAKE_COMMAND}" -E true
)
