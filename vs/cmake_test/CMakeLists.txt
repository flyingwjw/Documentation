find_package(Sqlite3 REQUIRED)
find_package(ZLIB REQUIRED)
find_package(freetype CONFIG)

add_executable(main main.cpp)
target_link_libraries(main sqlite3)
target_link_libraries(main ZLIB::ZLIB)
target_link_libraries(main freetype)