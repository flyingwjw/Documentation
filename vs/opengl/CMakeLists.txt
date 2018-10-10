find_package(glfw3 REQUIRED)
find_package(GLEW REQUIRED)
find_package(OpenGL REQUIRED)

add_executable(test test.cpp)

target_link_libraries(test PRIVATE glfw)
target_link_libraries(test PRIVATE GLEW::GLEW)
target_link_libraries(test PRIVATE ${OPENGL_LIBRARY})

add_executable(freeglut freeglut.cpp)

find_package(GLUT REQUIRED)
target_link_libraries(freeglut PRIVATE GLUT::GLUT)

