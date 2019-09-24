cmake_minimum_required(VERSION 3.2.3)

PROJECT("libtempsensor")

MESSAGE("*Use this path where the headers sleep")
MESSAGE("{CMAKE_BINARY_DIR}": ${CMAKE_BINARY_DIR})
MESSAGE("{CMAKE_CURRENT_SOURCE_DIR}:" ${CMAKE_CURRENT_SOURCE_DIR})

# TODO: detect host
SET(SOURCES_libtempsensor
    hid_LINUX.c)

#Hier wird das Target erstellt
ADD_LIBRARY(TARGET_libtempsensor
            STATIC
            ${SOURCES_libtempsensor}
)
SET_TARGET_PROPERTIES(TARGET_libtempsensor PROPERTIES OUTPUT_NAME "tempsensor")

#Hier werden die Header-Files?! dem Taget bekannt gemacht. Vorteil von TARGET_INCLUDE_DIRECTORIES gegenüber INCLUDE_DIRECTORIES 
#-> Saubere Variante, da in einem CMakeLists-File mehrere targets bearbeitet werden können und somit nur das bestimmte target die files zugesprochen werden
TARGET_INCLUDE_DIRECTORIES(TARGET_libtempsensor 
                           PUBLIC
                           ${CMAKE_BINARY_DIR}/install/include
)


#TARGET_LINK_LIBRARIES(TARGET_libtempsensor ${CMAKE_CURRENT_SOURCE_DIR}/${SOURCES_libtempsensor})
#TARGET_LINK_LIBRARIES(TARGET_libtempsensor
#                      PUBLIC ${CMAKE_BINARY_DIR}/install/lib/libusb.a
#)

#Install it
INSTALL(TARGETS TARGET_libtempsensor
        ARCHIVE DESTINATION ${CMAKE_BINARY_DIR}/install/lib
)
