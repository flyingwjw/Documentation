find_package(glfw3 CONFIG REQUIRED)
find_package(GLEW REQUIRED)
find_package(OpenGL REQUIRED)

add_executable(hello glfw.cpp)

target_link_libraries(hello PRIVATE glfw)
target_link_libraries(hello PRIVATE GLEW::GLEW)
target_link_libraries(hello PRIVATE ${OPENGL_LIBRARY})

add_executable(freeglut freeglut.cpp)

find_package(GLUT REQUIRED)
target_link_libraries(freeglut PRIVATE GLUT::GLUT)

