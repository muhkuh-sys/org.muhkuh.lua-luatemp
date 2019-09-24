cmake_minimum_required(VERSION 2.8)

PROJECT("external")

#----------------------------------------------------------------------------
#
# Include the projects in the subdirectories.
#
ADD_SUBDIRECTORY(libusb_1.0)
ADD_SUBDIRECTORY(libusb_compat_0.1)
ADD_SUBDIRECTORY(libtempsensor)

#----------------------------------------------------------------------------
