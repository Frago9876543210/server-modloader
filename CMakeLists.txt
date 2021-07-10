cmake_minimum_required(VERSION 3.11)
project(server_modloader)

include(FetchContent)
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(MODLOADER_VERSION "Preview 2")

FetchContent_Declare(funchook GIT_REPOSITORY https://github.com/kubo/funchook.git)
FetchContent_GetProperties(funchook)
if(NOT funchook_POPULATED)
    FetchContent_Populate(funchook)
    add_subdirectory(${funchook_SOURCE_DIR} ${funchook_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

add_subdirectory(symbols)

add_library(server_modloader SHARED include/modloader/hook.h include/modloader/statichook.h include/modloader/log.h
        include/modloader/loader.h
        src/hook.cpp src/log.cpp src/loader.h src/loader.cpp src/elf_helper.cpp src/elf_helper.h src/main.cpp)
target_link_libraries(server_modloader funchook-static symbols)
target_compile_definitions(server_modloader PRIVATE MODLOADER_VERSION="${MODLOADER_VERSION}")
target_include_directories(server_modloader PUBLIC ${CMAKE_SOURCE_DIR}/include/)

install(TARGETS server_modloader DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(DIRECTORY ${CMAKE_SOURCE_DIR}/include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(FILES ModLoaderConfig.cmake DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/modloader)