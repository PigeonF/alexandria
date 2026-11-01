cmake_minimum_required(VERSION 4.4 FATAL_ERROR)

project(
    consumer
    LANGUAGES CXX
)

include(FeatureSummary)

find_package(adder CONFIG REQUIRED)
adder_setup()

feature_summary(
  WHAT ALL
  INCLUDE_QUIET_PACKAGES
  DESCRIPTION "Feature summary:"
  FATAL_ON_MISSING_REQUIRED_PACKAGES
)

enable_testing()

add_executable(consumer
    src/consumer.cc
)
target_link_libraries(consumer
    PUBLIC
        adder::adder
)
add_test(
    NAME consumer
    COMMAND consumer
)
if(WIN32 AND BUILD_SHARED_LIBS)
    set_property(TEST consumer PROPERTY
        ENVIRONMENT_MODIFICATION
            "PATH=path_list_append:$<TARGET_FILE_DIR:adder::adder>"
    )
endif()

include(AdderPrintInfo)
adder_print_info()

add_custom_target(consumer_print_adder_libs ALL
    COMMAND "${CMAKE_COMMAND}" -E echo "<TARGET_FILE:adder::adder>        = $<TARGET_FILE:adder::adder>"
    COMMAND "${CMAKE_COMMAND}" -E echo "<TARGET_LINKER_FILE:adder::adder> = $<TARGET_LINKER_FILE:adder::adder>"
)
