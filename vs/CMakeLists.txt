cmake_minimum_required(VERSION 3.0)
SET(CMAKE_TOOLCHAIN_FILE "H:\\code\\vcpkg\\scripts\\buildsystems\\vcpkg.cmake")

project(vs)

add_subdirectory(cmake_test)
add_subdirectory(cmake_qt)
add_subdirectory(opengl)