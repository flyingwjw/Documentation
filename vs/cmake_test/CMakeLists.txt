find_package(Sqlite3 REQUIRED)

add_executable(main main.cpp)
target_link_libraries(main sqlite3)