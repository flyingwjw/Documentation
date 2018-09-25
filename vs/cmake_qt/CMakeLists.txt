set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(RESOURCE_DIR configdialog.qrc)

cmake_policy(SET CMP0058 NEW)

#find_package(Qt5Widgets)
find_package(Qt5 REQUIRED Widgets)
qt5_wrap_cpp( MOC widget.h)
qt5_wrap_ui( UIC widget.ui)
qt5_add_resources(RCC resources.qrc)

add_executable(qt main.cpp configdialog.cpp pages.cpp ${RESOURCE_DIR})

target_link_libraries(qt Qt5:Widgets)

