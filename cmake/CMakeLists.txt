cmake_minimum_required(VERSION 4.4 FATAL_ERROR)

project(
    cmake-tests
    LANGUAGES NONE
)

enable_testing()

add_test(
    NAME adder.shared.debug
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C Debug
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/adder" "${PROJECT_BINARY_DIR}/adder.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            "--presets-file=${PROJECT_SOURCE_DIR}/adder/CMakePresets.json"
            --preset=default
            -D "CMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/install"
            -D "BUILD_SHARED_LIBS=ON"
        --build-target install
        --test-command "${CMAKE_CTEST_COMMAND}" -C Debug
)
set_tests_properties(adder.shared.debug PROPERTIES
  FIXTURES_SETUP adder.shared.install
)

add_test(
    NAME adder.shared.release
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C Release
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/adder" "${PROJECT_BINARY_DIR}/adder.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            "--presets-file=${PROJECT_SOURCE_DIR}/adder/CMakePresets.json"
            --preset=default
            -D "CMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/install"
            -D "BUILD_SHARED_LIBS=ON"
        --build-target install
        --test-command "${CMAKE_CTEST_COMMAND}" -C Release
)
set_tests_properties(adder.shared.release PROPERTIES
  FIXTURES_SETUP adder.shared.install
)

add_test(
    NAME adder.static.debug
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C Debug
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/adder" "${PROJECT_BINARY_DIR}/adder.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            "--presets-file=${PROJECT_SOURCE_DIR}/adder/CMakePresets.json"
            --preset=default
            "-DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/install"
        --build-target install
        --test-command "${CMAKE_CTEST_COMMAND}" -C Debug
)
set_tests_properties(adder.static.debug PROPERTIES
  FIXTURES_SETUP adder.static.install
)

add_test(
    NAME adder.static.release
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C Release
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/adder" "${PROJECT_BINARY_DIR}/adder.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            "--presets-file=${PROJECT_SOURCE_DIR}/adder/CMakePresets.json"
            --preset=default
            "-DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/install"
        --build-target install
        --test-command "${CMAKE_CTEST_COMMAND}" -C Release
)
set_tests_properties(adder.static.release PROPERTIES
  FIXTURES_SETUP adder.static.install
)

add_test(
    NAME consumer.install_dir.shared
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.install_dir.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "BUILD_SHARED_LIBS=ON"
            -D "adder_ROOT=${PROJECT_BINARY_DIR}/install"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)
set_tests_properties(consumer.install_dir.shared PROPERTIES
    FIXTURES_REQUIRED adder.shared.install
)

add_test(
    NAME consumer.install_dir.static
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.install_dir.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "adder_ROOT=${PROJECT_BINARY_DIR}/install"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)
set_tests_properties(consumer.install_dir.static PROPERTIES
    FIXTURES_REQUIRED adder.static.install
)

add_test(
    NAME consumer.build_dir.shared
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.build_dir.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "BUILD_SHARED_LIBS=ON"
            -D "adder_DIR=${PROJECT_BINARY_DIR}/adder.shared"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)
set_tests_properties(consumer.build_dir.shared PROPERTIES
    FIXTURES_REQUIRED adder.shared.install
)

add_test(
    NAME consumer.build_dir.static
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.build_dir.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "adder_DIR=${PROJECT_BINARY_DIR}/adder.static"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)
set_tests_properties(consumer.build_dir.static PROPERTIES
    FIXTURES_REQUIRED adder.static.install
)

add_test(
    NAME consumer.fetchcontent.shared
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.fetchcontent.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "BUILD_SHARED_LIBS=ON"
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/FetchContent.cmake"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)

add_test(
    NAME consumer.fetchcontent.static
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.fetchcontent.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/FetchContent.cmake"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)

add_test(
    NAME consumer.add_subdirectory.shared
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.add_subdirectory.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "BUILD_SHARED_LIBS=ON"
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/AddSubdirectory.cmake"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)

add_test(
    NAME consumer.add_subdirectory.static
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.add_subdirectory.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/AddSubdirectory.cmake"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)

add_test(
    NAME consumer.pkgconfig.shared
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.pkgconfig.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "BUILD_SHARED_LIBS=ON"
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/PkgConfig.cmake"
            -D "CMAKE_PKG_CONFIG_PC_LIB_DIRS=${PROJECT_BINARY_DIR}/install/lib/pkgconfig"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)
set_tests_properties(consumer.pkgconfig.shared PROPERTIES
    FIXTURES_REQUIRED adder.shared.install
)

add_test(
    NAME consumer.pkgconfig.static
    COMMAND "${CMAKE_COMMAND}" -E env "CC=$ENV{CC}" "CXX=$ENV{CXX}"
        "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.pkgconfig.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/PkgConfig.cmake"
            -D "CMAKE_PKG_CONFIG_PC_LIB_DIRS=${PROJECT_BINARY_DIR}/install/lib/pkgconfig"
        --test-command "${CMAKE_CTEST_COMMAND}" -C "$<CONFIG>"
)
set_tests_properties(consumer.pkgconfig.static PROPERTIES
    FIXTURES_REQUIRED adder.static.install
)

# TODO(PigeonF): CommonPackageSpecification, SBOM
