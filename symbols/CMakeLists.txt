project(symbols LANGUAGES ASM)

set(CMAKE_ASM_CREATE_SHARED_LIBRARY "ld <CMAKE_SHARED_LIBRARY_CREATE_ASM_FLAGS> <CMAKE_SHARED_LIBRARY_SONAME_ASM_FLAG><TARGET_SONAME> <LINK_FLAGS> -o <TARGET> <OBJECTS>")

if ("${MODLOADER_SYMBOLS_TABLE}" STREQUAL "")
    message(FATAL_ERROR "Please specify MODLOADER_SYMBOLS_TABLE variable")
else ()
    add_library(symbols SHARED symbols.S)
    target_include_directories(symbols PUBLIC include/)
    target_compile_definitions(symbols PRIVATE MODLOADER_SYMBOLS_TABLE="${MODLOADER_SYMBOLS_TABLE}")
endif ()

install(TARGETS symbols DESTINATION ${CMAKE_INSTALL_LIBDIR})