# Licensed under the MIT License.

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(CMAKE_C_COMPILER_ID GNU)
set(CMAKE_C_COMPILER aarch64-poky-linux-gcc)
set(CMAKE_CXX_COMPILER aarch64-poky-linux-g++)
if (DEFINED ENV{PKG_CONFIG_SYSROOT_DIR})
    set (PKG_CONFIG_SYSROOT_DIR $ENV{PKG_CONFIG_SYSROOT_DIR})
endif ()
set(CMAKE_SYSROOT "${PKG_CONFIG_SYSROOT_DIR}")
set(LIBGCC_PATH "${PKG_CONFIG_SYSROOT_DIR}/usr/lib/aarch64-poky-linux/9.3.0")
