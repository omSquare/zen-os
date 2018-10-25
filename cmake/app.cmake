if(NOT DEFINED ENV{ZENOS_BASE})
    set(ENV{ZENOS_BASE} ${CMAKE_CURRENT_LIST_DIR}/..)
endif()

include($ENV{ZEPHYR_BASE}/cmake/app/boilerplate.cmake NO_POLICY_SCOPE)

set(__build_dir ${CMAKE_CURRENT_BINARY_DIR}/zen-os)

add_subdirectory($ENV{ZENOS_BASE} ${__build_dir})

