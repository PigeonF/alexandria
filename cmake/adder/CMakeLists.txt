cmake_minimum_required(VERSION 4.4 FATAL_ERROR)

project(
    adder
    LANGUAGES C
)

enable_testing()

add_library(adder_adder)
add_library(adder::adder ALIAS adder_adder)
target_sources(adder_adder
    PRIVATE
        src/add.c
    PUBLIC
        FILE_SET HEADERS
        BASE_DIRS
            include
        FILES
            include/adder/adder.h
            include/adder/add.h
)
set_target_properties(adder_adder
    PROPERTIES
        DEFINE_SYMBOL ADDER_BUILD_SHARED_LIBRARY
)

add_executable(adder_adder_add_test
    src/add_test.c
)
target_link_libraries(adder_adder_add_test
    PUBLIC
        adder::adder
)
add_test(
    NAME adder::adder::add
    COMMAND adder_adder_add_test
)

install(
    TARGETS
        adder_adder
)

add_subdirectory(tests)
