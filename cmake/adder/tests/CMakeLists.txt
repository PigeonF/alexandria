add_executable(adder_tests_adder
    adder.c
)
target_link_libraries(adder_tests_adder
    PUBLIC
        adder::adder
)
add_test(
    NAME adder::tests::adder
    COMMAND adder_tests_adder
)

if(WIN32 AND BUILD_SHARED_LIBS)
    set_property(TEST adder::tests::adder PROPERTY
        ENVIRONMENT_MODIFICATION
            "PATH=path_list_append:$<TARGET_FILE_DIR:adder::adder>"
    )
endif()
