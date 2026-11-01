cmake_minimum_required(VERSION 4.4 FATAL_ERROR)

project(
    adder
    LANGUAGES C
    VERSION 1.2.3
    HOMEPAGE_URL "https://github.com/PigeonF/alexandria"
    DESCRIPTION "Library for adding numbers"
    SPDX_LICENSE "Apache-2.0 OR MIT"
)

option(adder_ENABLE_INSTALL "Install adder" "${PROJECT_IS_TOP_LEVEL}")
option(adder_BUILD_TESTING "Build adder tests" "${PROJECT_IS_TOP_LEVEL}")

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

enable_testing()

configure_file(cmake/pkgconfig.pc.in "${CMAKE_CURRENT_BINARY_DIR}/generated/pkgconfig.pc.in" @ONLY)

if(BUILD_SHARED_LIBS)
    set(adder_export_file "adder-targets-shared.cmake")
    set(adder_pkgconfig_suffix "")
else()
    set(adder_export_file "adder-targets-static.cmake")
    set(adder_pkgconfig_suffix "-static")
endif()

set(adder_export_targets "")

add_library(adder_adder)
add_library(adder::adder ALIAS adder_adder)
list(APPEND adder_export_targets "adder_adder")
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
        EXPORT_NAME adder
        IMPORT_SUFFIX "${CMAKE_SHARED_LIBRARY_SUFFIX}${CMAKE_IMPORT_LIBRARY_SUFFIX}"
        OUTPUT_NAME adder
        SOVERSION "${PROJECT_VERSION_MAJOR}"
        VERSION "${PROJECT_VERSION}"
)
target_compile_definitions(
    adder_adder
        INTERFACE
            "$<$<BOOL:${BUILD_SHARED_LIBS}>:ADDER_SHARED_LIBRARY>"
)

file(GENERATE
    OUTPUT "${PROJECT_BINARY_DIR}/pkgconfig/adder${adder_pkgconfig_suffix}$<$<NOT:$<CONFIG:Release>>:-$<STRING:TOLOWER,$<CONFIG>>>.pc"
    INPUT "${CMAKE_CURRENT_BINARY_DIR}/generated/pkgconfig.pc.in"
    TARGET adder_adder
)

add_executable(adder_adder_add_test
    src/add_test.c
)
target_link_libraries(adder_adder_add_test
    PUBLIC
        adder::adder
)
set_target_properties(adder_adder_add_test
    PROPERTIES
        EXCLUDE_FROM_ALL "$<NOT:$<BOOL:adder_BUILD_TESTING>>"
)
if(adder_BUILD_TESTING)
    add_test(
        NAME adder::adder::add
        COMMAND adder_adder_add_test
    )
endif()

if(adder_BUILD_TESTING)
    add_subdirectory(tests)
endif()

export(
    TARGETS ${adder_export_targets}
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

write_basic_package_version_file(
    "${PROJECT_BINARY_DIR}/adder-config-version.cmake"
    COMPATIBILITY SemanticVersion
)

if(adder_ENABLE_INSTALL)
    install(
        TARGETS ${adder_export_targets}
        EXPORT adder-targets
        FILE_SET HEADERS
    )

    install(
        EXPORT adder-targets
        NAMESPACE adder::
        FILE "${adder_export_file}"
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/adder"
    )

    set(ADDER_EXTRA_CMAKE_DIR "\${CMAKE_CURRENT_FUNCTION_LIST_DIR}/cmake")
    configure_file(cmake/adder-extra.cmake.in "${CMAKE_CURRENT_BINARY_DIR}/generated/adder-extra.cmake" @ONLY)

    install(
        FILES
            "${PROJECT_BINARY_DIR}/adder-config.cmake"
            "${PROJECT_BINARY_DIR}/adder-config-version.cmake"
            "${CMAKE_CURRENT_BINARY_DIR}/generated/adder-extra.cmake"
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/adder"
    )
    install(
        FILES
            "${PROJECT_SOURCE_DIR}/cmake/AdderPrintInfo.cmake"
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/adder/cmake"
    )
    install(
        FILES
            "${PROJECT_BINARY_DIR}/pkgconfig/adder${adder_pkgconfig_suffix}$<$<NOT:$<CONFIG:Release>>:-$<STRING:TOLOWER,$<CONFIG>>>.pc"
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig"
    )
endif()
