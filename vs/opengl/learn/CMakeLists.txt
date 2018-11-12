include_directories(./include)


add_executable(hello_triangle src/hello_triangle.cpp glad.c)

target_link_libraries(hello_triangle PRIVATE glfw)
target_link_libraries(hello_triangle PRIVATE ${OPENGL_LIBRARY})