cmake_minimum_required(VERSION 3.0)
SET(CMAKE_TOOLCHAIN_FILE "E:\\share\\code\\vcpkg\\scripts\\buildsystems\\vcpkg.cmake")

project(text)

find_package(Sqlite3 REQUIRED)

add_executable(main main.cpp)
target_link_libraries(main sqlite3)