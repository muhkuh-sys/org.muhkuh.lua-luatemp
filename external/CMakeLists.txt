cmake_minimum_required(VERSION 2.8)

PROJECT("external")

#----------------------------------------------------------------------------
#
# Include the projects in the subdirectories.
#

# Linux builds need libusb.
IF(UNIX)
	ADD_SUBDIRECTORY(libusb_1.0)
	ADD_SUBDIRECTORY(libusb_compat_0.1)
ENDIF(UNIX)
ADD_SUBDIRECTORY(libtempsensor)

#----------------------------------------------------------------------------
