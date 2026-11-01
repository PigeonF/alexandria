if(BUILD_SHARED_LIBS)
    set(pkgconfig_suffix "")
else()
    set(pkgconfig_suffix "-static")
endif()

cmake_pkg_config(
    IMPORT adder${pkgconfig_suffix}
    NAME adder
    REQUIRED
    STRICTNESS STRICT
)

add_library(adder::adder ALIAS PkgConfig::adder)

file(TOUCH "${CMAKE_FIND_PACKAGE_REDIRECTS_DIR}/adder-config.cmake")

set(ADDER_EXTRA_CMAKE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../adder/cmake")
configure_file(
    "${ADDER_EXTRA_CMAKE_DIR}/adder-extra.cmake.in"
    "${PROJECT_BINARY_DIR}/adder-extra.cmake"
    @ONLY
)
include("${PROJECT_BINARY_DIR}/adder-extra.cmake")

if(WIN32 AND BUILD_SHARED_LIBS)
    set(consumer_DISABLE_TEST ON)
endif()
