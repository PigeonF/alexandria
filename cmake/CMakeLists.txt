cmake_minimum_required(VERSION 4.4 FATAL_ERROR)

project(
    cmake-tests
    LANGUAGES NONE
)

enable_testing()

add_test(
    NAME adder.shared
    COMMAND "${CMAKE_CTEST_COMMAND}"
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
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME adder.static
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/adder" "${PROJECT_BINARY_DIR}/adder.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            "--presets-file=${PROJECT_SOURCE_DIR}/adder/CMakePresets.json"
            --preset=default
            "-DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/install"
        --build-target install
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME consumer.install_dir.shared
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.install_dir.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "BUILD_SHARED_LIBS=ON"
            -D "adder_ROOT=${PROJECT_BINARY_DIR}/install"
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME consumer.install_dir.static
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.install_dir.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "adder_ROOT=${PROJECT_BINARY_DIR}/install"
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME consumer.build_dir.shared
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.build_dir.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "BUILD_SHARED_LIBS=ON"
            -D "adder_DIR=${PROJECT_BINARY_DIR}/adder.shared"
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME consumer.build_dir.static
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.build_dir.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "adder_DIR=${PROJECT_BINARY_DIR}/adder.static"
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME consumer.fetchcontent.shared
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.fetchcontent.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "BUILD_SHARED_LIBS=ON"
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/FetchContent.cmake"
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME consumer.fetchcontent.static
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.fetchcontent.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/FetchContent.cmake"
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME consumer.add_subdirectory.shared
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.add_subdirectory.shared"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "BUILD_SHARED_LIBS=ON"
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/AddSubdirectory.cmake"
        --test-command "${CMAKE_CTEST_COMMAND}"
)

add_test(
    NAME consumer.add_subdirectory.static
    COMMAND "${CMAKE_CTEST_COMMAND}"
        --verbose
        --build-and-test "${PROJECT_SOURCE_DIR}/consumer" "${PROJECT_BINARY_DIR}/consumer.add_subdirectory.static"
        --build-generator "${CMAKE_GENERATOR}"
        --build-two-config
        --build-options
            -D "CMAKE_PROJECT_consumer_INCLUDE=${PROJECT_SOURCE_DIR}/consumer/cmake/AddSubdirectory.cmake"
        --test-command "${CMAKE_CTEST_COMMAND}"
)

# TODO(PigeonF): pkgconfig, CommonPackageSpecification, SBOM
