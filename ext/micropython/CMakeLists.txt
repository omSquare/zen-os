if (NOT DEFINED ENV{MICROPYTHON_BASE})
    message(FATAL_ERROR "MICROPYTHON_BASE is not defined, please specify micropython repository")
endif ()

set(__build_dir ${CMAKE_CURRENT_BINARY_DIR}/micropython)

add_subdirectory($ENV{MICROPYTHON_BASE} ${__build_dir})

target_include_directories(micropython BEFORE PRIVATE
        include
        )

zephyr_get_compile_options_for_lang(C zephyr_flags)
zephyr_get_compile_definitions_for_lang(C zephyr_defs)
get_property(zephyr_inc TARGET zephyr_interface PROPERTY INTERFACE_INCLUDE_DIRECTORIES)

target_compile_options(micropython PRIVATE ${zephyr_flags})
target_compile_definitions(micropython PRIVATE ${zephyr_defs})
target_include_directories(micropython PRIVATE ${zephyr_inc})

add_library(micropython_wrap INTERFACE)
target_include_directories(micropython_wrap INTERFACE
        $ENV{MICROPYTHON_BASE}
)
target_link_libraries(micropython_wrap INTERFACE micropython)

add_dependencies(micropython-generate-qstr syscall_list_h_target syscall_macros_h_target kobj_types_h_target)
add_dependencies(micropython_wrap micropython)
add_dependencies(app micropython_wrap)

#TODO remove
#add_dependencies(zenos micropython)
# add public includes to app
#zephyr_append_cmake_library()
#get_property(zephyr_sysinc TARGET zephyr_interface PROPERTY INTERFACE_SYSTEM_INCLUDE_DIRECTORIES)
#message("zephyr_sysinc: ${zephyr_sysinc}")
#get_property(flags TARGET micropython PROPERTY COMPILE_OPTIONS)
#message("C_FLAGS2=${flags}")
