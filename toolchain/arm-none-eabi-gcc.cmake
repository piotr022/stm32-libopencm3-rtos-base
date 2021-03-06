set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if(MINGW OR CYGWIN OR WIN32)
    set(UTIL_SEARCH_CMD where)
elseif(UNIX OR APPLE)
    set(UTIL_SEARCH_CMD which)
endif()

set(TOOLCHAIN_PREFIX arm-none-eabi)

execute_process(
  COMMAND ${UTIL_SEARCH_CMD} ${TOOLCHAIN_PREFIX}-gcc
  OUTPUT_VARIABLE BINUTILS_PATH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

get_filename_component(ARM_TOOLCHAIN_DIR ${BINUTILS_PATH} DIRECTORY)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

SET(CMAKE_AR               ${TOOLCHAIN_PREFIX}-gcc-ar${EXE})
SET(CMAKE_RANLIB           ${TOOLCHAIN_PREFIX}-gcc-ranlib${EXE})
SET(CMAKE_LD               ${TOOLCHAIN_PREFIX}-ld${EXE})
set(CMAKE_C_COMPILER       ${TOOLCHAIN_PREFIX}-gcc${EXE})
set(CMAKE_CXX_COMPILER     ${TOOLCHAIN_PREFIX}-g++${EXE})
set(CMAKE_ASM_COMPILER     ${TOOLCHAIN_PREFIX}-gcc${EXE})
set(CMAKE_OBJCOPY     	   ${TOOLCHAIN_PREFIX}-objcopy${EXE} CACHE INTERNAL "objcopy command")
set(CMAKE_OBJDUMP     	   ${TOOLCHAIN_PREFIX}-objdump${EXE} CACHE INTERNAL "objdump command")
set(CMAKE_GDB              ${TOOLCHAIN_PREFIX}-gdb${EXE})
set(CMAKE_SIZE             ${TOOLCHAIN_PREFIX}-size${EXE})


set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
