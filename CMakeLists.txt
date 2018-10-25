cmake_minimum_required(VERSION 3.8)

#zephyr_library_named(zenos)
zephyr_include_directories(include)
zephyr_sources(
        src/empty.c
)

add_subdirectory(ext)