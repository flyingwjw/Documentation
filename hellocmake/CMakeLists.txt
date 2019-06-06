if (WIN32)
    cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
else()
    cmake_minimum_required(VERSION 2.8.0 FATAL_ERROR)
endif()

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release
        CACHE STRING "Set build type to Debug o Release (default Release)" FORCE)
endif()

project(nebula C)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")

set(HELLOWORLD_VERSION_MAJOR 1)
set(HELLOWORLD_VERSION_MINOR 0)
set(HELLOWORLD_VERSION_PATCH 0)
set(HELLOWORLD_VERSION_STAGE beta)

set(HELLOWORLD_ABI_MAJOR ${HELLOWORLD_VERSION_MAJOR})
set(HELLOWORLD_ABI_MINOR ${HELLOWORLD_VERSION_MINOR})
set(HELLOWORLD_ABI_PATCH ${HELLOWORLD_VERSION_PATCH})

set(HELLOWORLD_ABI_LIBVERSION
    "${HELLOWORLD_ABI_MAJOR}.${HELLOWORLD_ABI_MINOR}.${HELLOWORLD_ABI_PATCH}")

set(HELLOWORLD_PACKAGE_VERSION
    "${HELLOWORLD_VERSION_MAJOR}.${HELLOWORLD_VERSION_MINOR}.${HELLOWORLD_VERSION_PATCH}")

# only a subset of names can be used, defaults to "beta"
set(HELLOWORLD_STAGE_NAME ${HELLOWORLD_VERSION_STAGE}
    CACHE STRING "set the stage name (beta|alpha|release)")

# a list that defines what can set for EVENT_STAGE_VERSION
set(HELLOWORLD__ALLOWED_STAGE_NAMES
    rc
    beta
    alpha
    release)

# attempt to find the EVENT__STAGE_VERSION in the allowed list
# of accepted stage names, the return value is stord in
# EVENT__STAGE_RET

option(HELLOWORLD__BUILD_SHARED_LIBRARIES
    "Define if libevent should be built with shared libraries instead of archives" ON)

option(NEBULA__DISABLE_SAMPLES
    "Disable sample files" OFF)

list(FIND HELLOWORLD__ALLOWED_STAGE_NAMES
    ${HELLOWORLD_STAGE_NAME}
    HELLOWORLD__STAGE_RET)

if (HELLOWORLD__STAGE_RET EQUAL "-1")
    set(HELLOWORLD_STAGE_NAME beta)
endif()

set(HELLOWORLD_VERSION
    "${HELLOWORLD_VERSION_MAJOR}.${HELLOWORLD_VERSION_MINOR}.${HELLOWORLD_VERSION_PATCH}-${HELLOWORLD_STAGE_NAME}")

# Put the libaries and binaries that get built into directories at the
# top of the build tree rather than in hard-to-find leaf directories.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

if (HELLOWORLD__ENABLE_VERBOSE_DEBUG)
    add_definitions(-DUSE_DEBUG=1)
endif()

# GCC specific options.
if (CMAKE_COMPILER_IS_GNUCC)
    option(HELLOWORLD__DISABLE_GCC_WARNINGS "Disable verbose warnings with GCC" OFF)
    option(HELLOWORLD__ENABLE_GCC_HARDENING "Enable compiler security checks" OFF)
    option(HELLOWORLD__ENABLE_GCC_FUNCTION_SECTIONS "Enable gcc function sections" OFF)
    option(HELLOWORLD__ENABLE_GCC_WARNINGS "Make all GCC warnings into errors" OFF)

    list(APPEND __FLAGS -Wall -Wswitch)

    if (HELLOWORLD__DISABLE_GCC_WARNINGS)
        list(APPEND __FLAGS -w)
    endif()

    if (HELLOWORLD__ENABLE_GCC_HARDENING)
        list(APPEND __FLAGS
             -fstack-protector-all
             -fwrapv
             -fPIE
             -Wstack-protector
             "--param ssp-buffer-size=1")

        add_definitions(-D_FORTIFY_SOURCE=2)
    endif()

    if (HELLOWORLD__ENABLE_GCC_FUNCTION_SECTIONS)
        list(APPEND __FLAGS -ffunction-sections)
        # TODO: Add --gc-sections support. We need some checks for NetBSD to ensure this works.
    endif()

    if (HELLOWORLD__ENABLE_GCC_WARNINGS)
        list(APPEND __FLAGS -Werror)
    endif()

    # We need to test for at least gcc 2.95 here, because older versions don't
    # have -fno-strict-aliasing
    list(APPEND __FLAGS -fno-strict-aliasing)

    add_compiler_flags(${__FLAGS})
endif()

# Group the source files.
set(HDR_PUBLIC
    include/hello.h
	include/visibility.h
	${CMAKE_CURRENT_BINARY_DIR}/include/nebula-config.h
	)

set(SRC_CORE
    hello.c
	)

add_definitions(-DHAVE_CONFIG_H)

# We use BEFORE here so we don't accidentally look in system directories
# first for some previous versions of the headers that are installed.
include_directories(BEFORE ${PROJECT_SOURCE_DIR}/include)

source_group("Headers Public"  FILES ${HDR_PUBLIC})
source_group("Headers Private"  FILES ${HDR_PRIVATE})
source_group("Source Core"      FILES ${SRC_CORE})

# Generate the configure headers.
# (Place them in the build dir so we don't polute the source tree with generated files).
include_directories(BEFORE ${CMAKE_CURRENT_BINARY_DIR}/include)

if (HELLOWORLD__BUILD_SHARED_LIBRARIES)
  set(HELLOWORLD__LIBRARY_TYPE SHARED)

  if ((CMAKE_COMPILER_IS_GNUCC) OR (${CMAKE_C_COMPILER_ID} STREQUAL "Clang"))
        add_compiler_flags(-fvisibility=hidden)
  elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "SunPro")
    add_compiler_flags(-xldscope=hidden)
  endif()

  set(NEBULA__NEED_DLLEXPORT 1)
else (HELLOWORLD__BUILD_SHARED_LIBRARIES)
  set(HELLOWORLD__LIBRARY_TYPE STATIC)
endif (HELLOWORLD__BUILD_SHARED_LIBRARIES)


# Generate the configure headers.
configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/nebula-config.h.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/include/nebula-config.h
        NEWLINE_STYLE UNIX)

#
# Create the libraries.
#

add_library(helloworld ${HELLOWORLD__LIBRARY_TYPE}
    ${HDR_PUBLIC}
    ${SRC_CORE})

if (HELLOWORLD__BUILD_SHARED_LIBRARIES)
  set_target_properties(helloworld
        PROPERTIES SOVERSION ${HELLOWORLD_ABI_LIBVERSION})
endif (HELLOWORLD__BUILD_SHARED_LIBRARIES)

#
# Samples.
#

if (NOT NEBULA__DISABLE_SAMPLES)
    set(SAMPLES
        hello-world
        )

    foreach(SAMPLE ${SAMPLES})
        add_executable(${SAMPLE}
                    sample/${SAMPLE}.c)

        target_link_libraries(${SAMPLE}
                    helloworld)

        add_dependencies(${SAMPLE} helloworld)
    endforeach()
endif()

#
# Installation preparation.
#

# Allow the user to override installation directories.
set(HELLOWORLD_INSTALL_LIB_DIR       lib CACHE PATH "Installation directory for libraries")
set(HELLOWORLD_INSTALL_BIN_DIR       bin CACHE PATH "Installation directory for executables")
set(HELLOWORLD_INSTALL_INCLUDE_DIR   include CACHE PATH "Installation directory for header files")

if(WIN32 AND NOT CYGWIN)
  set(DEF_INSTALL_CMAKE_DIR cmake)
else()
  set(DEF_INSTALL_CMAKE_DIR lib/cmake/helloworld)
endif()

set(HELLOWORLD_INSTALL_CMAKE_DIR ${DEF_INSTALL_CMAKE_DIR} CACHE PATH "Installation directory for CMake files")

# Make sure the paths are absolute.
foreach(p INCLUDE CMAKE)
    set(var HELLOWORLD_INSTALL_${p}_DIR)
    if(NOT IS_ABSOLUTE "${${var}}")
        set(${var}_FULL "${CMAKE_INSTALL_PREFIX}/${${var}}")
    endif()
endforeach()

# Export targets (This is used for other CMake projects to easily find the libraries and include files).
export(TARGETS helloworld
        FILE "${PROJECT_BINARY_DIR}/LibhelloworldTargets.cmake")
export(PACKAGE helloworld)

# Generate the config file for the build-tree.
set(HELLOWORLD__INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/include"
    "${PROJECT_BINARY_DIR}/include")

set(LIBHELLOWORLD_INCLUDE_DIRS
    ${HELLOWORLD__INCLUDE_DIRS}
    CACHE PATH "Libhelloworld include directories")

configure_file(${PROJECT_SOURCE_DIR}/cmake/LibhelloworldConfigBuildTree.cmake.in
                ${PROJECT_BINARY_DIR}/LibhelloworldConfig.cmake
                @ONLY)

configure_file(${PROJECT_SOURCE_DIR}/cmake/LibhelloworldConfig.cmake.in
                ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/LibhelloworldConfig.cmake
                @ONLY)

# Generate version info for both build-tree and install-tree.
configure_file(${PROJECT_SOURCE_DIR}/cmake/LibhelloworldConfigVersion.cmake.in
                ${PROJECT_BINARY_DIR}/LibhelloworldConfigVersion.cmake
                @ONLY)

# Define the public headers.
set_target_properties(helloworld
    PROPERTIES PUBLIC_HEADER "${HDR_PUBLIC}")

#
# Install targets.
#
install(TARGETS helloworld
        EXPORT LibhelloworldTargets
        RUNTIME DESTINATION "${HELLOWORLD_INSTALL_BIN_DIR}" COMPONENT bin
        LIBRARY DESTINATION "${HELLOWORLD_INSTALL_LIB_DIR}" COMPONENT lib
        ARCHIVE DESTINATION "${HELLOWORLD_INSTALL_LIB_DIR}" COMPONENT lib
        PUBLIC_HEADER DESTINATION "${HELLOWORLD_INSTALL_INCLUDE_DIR}" COMPONENT dev)

# Install compat headers
install(FILES ${HDR_COMPAT}
        DESTINATION
            "${HELLOWORLD_INSTALL_INCLUDE_DIR}"
        COMPONENT dev)

# Install the configs.
install(FILES
        ${PROJECT_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/LibhelloworldConfig.cmake
        ${PROJECT_BINARY_DIR}/LibhelloworldConfigVersion.cmake
        DESTINATION
            "${HELLOWORLD_INSTALL_CMAKE_DIR}"
        COMPONENT dev)

# Install exports for the install-tree.
install(EXPORT LibhelloworldTargets
        DESTINATION
            "${HELLOWORLD_INSTALL_CMAKE_DIR}"
        COMPONENT dev)

set(HELLOWORLD_LIBRARIES
        helloworld
        CACHE STRING "helloworld libraries")

message(STATUS "")
message(STATUS "        ---( helloworld " ${HELLOWORLD_VERSION} " )---")
message(STATUS "")
message(STATUS "Available event backends: ${BACKENDS}")
message(STATUS "CMAKE_BINARY_DIR:         " ${CMAKE_BINARY_DIR})
message(STATUS "CMAKE_CURRENT_BINARY_DIR: " ${CMAKE_CURRENT_BINARY_DIR})
message(STATUS "CMAKE_SOURCE_DIR:         " ${CMAKE_SOURCE_DIR})
message(STATUS "CMAKE_CURRENT_SOURCE_DIR: " ${CMAKE_CURRENT_SOURCE_DIR})
message(STATUS "PROJECT_BINARY_DIR:       " ${PROJECT_BINARY_DIR})
message(STATUS "PROJECT_SOURCE_DIR:       " ${PROJECT_SOURCE_DIR})
message(STATUS "CMAKE_MODULE_PATH:        " ${CMAKE_MODULE_PATH})
message(STATUS "CMAKE_COMMAND:            " ${CMAKE_COMMAND})
message(STATUS "CMAKE_ROOT:               " ${CMAKE_ROOT} )
message(STATUS "CMAKE_SYSTEM:             " ${CMAKE_SYSTEM} )
message(STATUS "CMAKE_SYSTEM_NAME:        " ${CMAKE_SYSTEM_NAME} )
message(STATUS "CMAKE_SYSTEM_VERSION:     " ${CMAKE_SYSTEM_VERSION} )
message(STATUS "CMAKE_SYSTEM_PROCESSOR:   " ${CMAKE_SYSTEM_PROCESSOR} )
message(STATUS "CMAKE_SKIP_RPATH:         " ${CMAKE_SKIP_RPATH} )
message(STATUS "CMAKE_VERBOSE_MAKEFILE:   " ${CMAKE_VERBOSE_MAKEFILE} )
message(STATUS "CMAKE_C_FLAGS:            " ${CMAKE_C_FLAGS} )
message(STATUS "CMAKE_BUILD_TYPE:         " ${CMAKE_BUILD_TYPE} )
message(STATUS "CMAKE_C_COMPILER:         " ${CMAKE_C_COMPILER} )
message(STATUS "CMAKE_AR:                 " ${CMAKE_AR} )
message(STATUS "CMAKE_RANLIB:             " ${CMAKE_RANLIB} )
message(STATUS "CMAKE_PREFIX_PATH:        " ${CMAKE_PREFIX_PATH} )
message(STATUS "CMAKE_INSTALL_PREFIX:     " ${CMAKE_INSTALL_PREFIX} )
message(STATUS "")
