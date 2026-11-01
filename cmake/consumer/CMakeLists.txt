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
            "$<LIST:TRANSFORM,$<TARGET_RUNTIME_DLL_DIRS:consumer>,PREPEND,PATH=path_list_append:>"
    )
endif()

if(consumer_DISABLE_TEST)
    set_tests_properties(consumer PROPERTIES DISABLED TRUE)
endif()

include(AdderPrintInfo)
adder_print_info()
