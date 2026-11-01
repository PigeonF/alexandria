include_guard(DIRECTORY)

function(adder_print_info)
    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E echo "adder_DIR           = ${adder_DIR}"
    )
    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E echo "adder_FOUND         = ${adder_FOUND}"
    )
    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E echo "adder_VERSION       = ${adder_VERSION}"
    )
    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E echo "adder_VERSION_MAJOR = ${adder_VERSION_MAJOR}"
    )
endfunction()
