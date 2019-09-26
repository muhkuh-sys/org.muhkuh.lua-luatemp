cmake_minimum_required(VERSION 3.7)

#----------------------------------------------------------------------------
#
# Build libusb and create a CMake component.
#
PROJECT("libusb_compat_0.1")

SET(VERSION_EXTERNAL "0.1.7")

INCLUDE(ExternalProject)


#----------------------------------------------------------------------------
#
# Construct the host ID for the configure command.
#
IF(${CMAKE_CROSSCOMPILING})
	IF(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		# Get the prefix of the compiler.
		GET_FILENAME_COMPONENT(GCC_BASENAME ${CMAKE_C_COMPILER} NAME)
		IF(GCC_BASENAME MATCHES "([^-]+-[^-]+-[^-]+)-gcc")
			SET(CONFIGURE_HOST "--host=${CMAKE_MATCH_1}")
		ELSE(GCC_BASENAME MATCHES "([^-]+-[^-]+-[^-]+)-gcc")
			MESSAGE(FATAL_ERROR "Failed to extract the compiler prefix from the C compiler ${CMAKE_C_COMPILER}")
		ENDIF(GCC_BASENAME MATCHES "([^-]+-[^-]+-[^-]+)-gcc")
	ELSE(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		MESSAGE(FATAL_ERROR "Cross compiling detected, but not using GCC. This is currently not supported.")
	ENDIF(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
ENDIF(${CMAKE_CROSSCOMPILING})

#----------------------------------------------------------------------------
#
# Build the project.
#
ExternalProject_Add(TARGET_libusb_compat
                    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/libusb_compat_${VERSION_EXTERNAL}
                    URL ${CMAKE_CURRENT_SOURCE_DIR}/libusb-compat-${VERSION_EXTERNAL}.tar.bz2
                    URL_HASH SHA1=335724bbf99369a53e7eec21e1e6b04618459575
                    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E env "LIBUSB_1_0_CFLAGS=-I${CMAKE_BINARY_DIR}/libusb_1.0/install/include" "LIBUSB_1_0_LIBS=${CMAKE_BINARY_DIR}/libusb_1.0/install/lib/libusb.a" ${CMAKE_CURRENT_BINARY_DIR}/libusb_compat_${VERSION_EXTERNAL}/src/TARGET_libusb_compat/configure --prefix=${CMAKE_BINARY_DIR}/install --enable-shared=no --enable-static=yes --with-pic=yes ${CONFIGURE_HOST}
                    BUILD_COMMAND ${CMAKE_MAKE_PROGRAM}
                    INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install
)
