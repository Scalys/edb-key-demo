# Copyright (c) Open Enclave SDK contributors.
# Licensed under the MIT License.

include(../cmake/add-enclave.cmake)

include_directories(
    ${CMAKE_SOURCE_DIR}/libs
    ${CMAKE_SOURCE_DIR}/libs/gemmlowp
    ${CMAKE_SOURCE_DIR}/libs/ruy
    ${CMAKE_SOURCE_DIR}/enc/inc
    ${CMAKE_SOURCE_DIR}/common
    ${PKG_CONFIG_SYSROOT_DIR}/opt/tflite-micro/third_party/flatbuffers/include
    ${PKG_CONFIG_SYSROOT_DIR}/opt/tflite-micro/third_party/gemmlowp
    ${PKG_CONFIG_SYSROOT_DIR}/opt/tflite-micro/third_party/kissfft
    ${PKG_CONFIG_SYSROOT_DIR}/opt/tflite-micro/third_party/pigweed
    ${PKG_CONFIG_SYSROOT_DIR}/opt/tflite-micro/third_party/ruy
    ${PKG_CONFIG_SYSROOT_DIR}/opt/tflite-micro
#    ${TENSORFLOW_LITE_INC}
)

add_custom_command(
  OUTPUT
    edb_key_demo_t.h
    edb_key_demo_t.c
    edb_key_demo_args.h
  DEPENDS ${CMAKE_SOURCE_DIR}/edb_key_demo.edl
  COMMAND openenclave::oeedger8r --trusted ${CMAKE_SOURCE_DIR}/edb_key_demo.edl
    --search-path ${PKG_CONFIG_SYSROOT_DIR}/opt/oe/${OE_OPTEE_PLATFORM}/include
    --search-path ${PKG_CONFIG_SYSROOT_DIR}/opt/oe/${OE_OPTEE_PLATFORM}/include/openenclave/edl
    --search-path ${PKG_CONFIG_SYSROOT_DIR}/opt/oe/${OE_OPTEE_PLATFORM}/include/openenclave/edl/optee
)

add_custom_command(
  OUTPUT
    edb_key_demo_model_data.cc
    edb_key_demo_model_data.h
  DEPENDS ${CMAKE_SOURCE_DIR}/scripts/generate_cc_arrays.py
  COMMAND
    python3 ${CMAKE_SOURCE_DIR}/scripts/generate_cc_arrays.py ${CMAKE_CURRENT_BINARY_DIR}/edb_key_demo_model_data.cc ${CMAKE_SOURCE_DIR}/models/edb_key_demo.tflite &&
    python3 ${CMAKE_SOURCE_DIR}/scripts/generate_cc_arrays.py ${CMAKE_CURRENT_BINARY_DIR}/edb_key_demo_model_data.h ${CMAKE_SOURCE_DIR}/models/edb_key_demo.tflite
)

add_enclave(
  TARGET edb_key_demo_enclave
  UUID 1f574668-6c89-41b5-b313-4b2d85d63c9d
    SOURCES
    enc.cc
    ${CMAKE_CURRENT_BINARY_DIR}/edb_key_demo_model_data.cc
    ${CMAKE_CURRENT_BINARY_DIR}/edb_key_demo_t.c)

target_compile_options(edb_key_demo_enclave
  PRIVATE "-DTF_LITE_STATIC_MEMORY"
)

target_link_libraries(edb_key_demo_enclave
  ${PKG_CONFIG_SYSROOT_DIR}/opt/tflite-micro/tensorflow/lite/micro/tools/make/gen/linux_aarch64_debug/lib/libtensorflow-microlite.a
)

target_link_libraries(edb_key_demo_enclave openenclave::oeenclave openenclave::oecryptombedtls)
