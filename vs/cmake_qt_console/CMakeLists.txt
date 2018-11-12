find_package(Qt5Core)

add_executable(test_qt_console test_console.cpp)

target_link_libraries(test_qt_console Qt5::Core)

