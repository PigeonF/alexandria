include(FetchContent)

FetchContent_Declare(adder
    SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../adder"
    OVERRIDE_FIND_PACKAGE
)

FetchContent_MakeAvailable(
    adder
)
