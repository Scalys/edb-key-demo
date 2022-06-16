# Copyright (c) Open Enclave SDK contributors.
# Licensed under the MIT License.

add_custom_command(
  OUTPUT
    edb_key_demo_u.h
    edb_key_demo_u.c
    edb_key_demo_args.h
  DEPENDS ${CMAKE_SOURCE_DIR}/edb_key_demo.edl
  COMMAND openenclave::oeedger8r --untrusted ${CMAKE_SOURCE_DIR}/edb_key_demo.edl
  --search-path ${PKG_CONFIG_SYSROOT_DIR}/opt/oe/${OE_OPTEE_PLATFORM}/include
  --search-path ${PKG_CONFIG_SYSROOT_DIR}/opt/oe/${OE_OPTEE_PLATFORM}/include/openenclave/edl
  --search-path ${PKG_CONFIG_SYSROOT_DIR}/opt/oe/${OE_OPTEE_PLATFORM}/include/openenclave/edl/optee)

include_directories(
    ${CMAKE_SOURCE_DIR}/libs
    ${CMAKE_SOURCE_DIR}/common
)

add_executable(edb_key_demo
    host.cc
    capture.cc
    main.cc
    ${CMAKE_CURRENT_BINARY_DIR}/edb_key_demo_u.c)

target_include_directories(edb_key_demo PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(edb_key_demo openenclave::oehost)
