include_guard(DIRECTORY)

add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/../../adder" "${CMAKE_CURRENT_BINARY_DIR}/adder")
include("${CMAKE_CURRENT_BINARY_DIR}/adder/adder-extra.cmake")

file(COPY "${CMAKE_CURRENT_BINARY_DIR}/adder/adder-config-version.cmake" DESTINATION "${CMAKE_FIND_PACKAGE_REDIRECTS_DIR}")
file(TOUCH "${CMAKE_FIND_PACKAGE_REDIRECTS_DIR}/adder-config.cmake")
