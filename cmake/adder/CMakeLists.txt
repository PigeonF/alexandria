cmake_minimum_required(VERSION 4.4 FATAL_ERROR)

project(
    adder
    LANGUAGES C
    VERSION 1.2.3
    HOMEPAGE_URL "https://github.com/PigeonF/alexandria"
    DESCRIPTION "Library for adding numbers"
    SPDX_LICENSE "Apache-2.0 OR MIT"
)

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

enable_testing()

if(BUILD_SHARED_LIBS)
    set(adder_export_suffix "_shared")
    set(adder_export_file "adder-targets-shared.cmake")
else()
    set(adder_export_suffix "_static")
    set(adder_export_file "adder-targets-static.cmake")
endif()

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
        EXPORT_NAME "adder${adder_export_suffix}"
        IMPORT_SUFFIX "${CMAKE_SHARED_LIBRARY_SUFFIX}${CMAKE_IMPORT_LIBRARY_SUFFIX}"
        OUTPUT_NAME adder
        SOVERSION "${PROJECT_VERSION_MAJOR}"
        VERSION "${PROJECT_VERSION}"
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

add_subdirectory(tests)

install(
    TARGETS
        adder_adder
    EXPORT adder-targets
    FILE_SET HEADERS
)

install(
    EXPORT adder-targets
    NAMESPACE adder::
    FILE "${adder_export_file}"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/adder"
)
export(
    EXPORT adder-targets
    NAMESPACE adder::
    FILE "${adder_export_file}"
)

# NOTE(PigeonF): Need different include path at build time compared to install time
set(ADDER_EXTRA_CMAKE_DIR "${PROJECT_SOURCE_DIR}/cmake")
configure_file(cmake/adder-extra.cmake.in "${PROJECT_BINARY_DIR}/adder-extra.cmake" @ONLY)
file(COPY "${PROJECT_BINARY_DIR}/adder-extra.cmake" DESTINATION "${CMAKE_FIND_PACKAGE_REDIRECTS_DIR}")

configure_package_config_file(
    cmake/adder-config.cmake.in
    "${PROJECT_BINARY_DIR}/adder-config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/adder"
)
install(
    FILES "${PROJECT_BINARY_DIR}/adder-config.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/adder"
)

write_basic_package_version_file(
    "${PROJECT_BINARY_DIR}/adder-config-version.cmake"
    COMPATIBILITY SemanticVersion
)
install(
    FILES "${PROJECT_BINARY_DIR}/adder-config-version.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/adder"
)

set(ADDER_EXTRA_CMAKE_DIR "\${CMAKE_CURRENT_FUNCTION_LIST_DIR}/cmake")
configure_file(cmake/adder-extra.cmake.in "${CMAKE_CURRENT_BINARY_DIR}/generated/adder-extra.cmake" @ONLY)
install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/generated/adder-extra.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/adder"
)
install(
    FILES
        "${PROJECT_SOURCE_DIR}/cmake/AdderPrintInfo.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/adder/cmake"
)
