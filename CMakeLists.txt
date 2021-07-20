cmake_minimum_required(VERSION 3.15)

set(OPTI_FLAG 3)
set(CMAKE_BUILD_TYPE Debug)

#setting stm specific target defines, todo : -DUSE_OVERCLOCK 
set(STM32_DEFINES "-DSTM32F1 -DSTM32F103xx -DSTM32 -DSTM32F10X_HD")

set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_TOOLCHAIN_FILE toolchain/arm-none-eabi-gcc.cmake)
include(toolchain/arm-none-eabi-gcc.cmake)


set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++)


project(fly C CXX ASM)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(EXECUTABLE ${PROJECT_NAME}.out)


include(cmake/libopencm3.cmake) #add libopencm3
include(cmake/freertos.cmake)   #add freertos

set(COMPILER_OPTIONS " -mthumb -mcpu=cortex-m3 -mlittle-endian -mthumb-interwork -fno-lto -msoft-float -mfix-cortex-m3-ldrd -fno-common -ffunction-sections -fdata-sections -O${OPTI_FLAG}")

if(<CMAKE_BUILD_TYPE EQUAL Debug>)
        set(COMPILER_OPTIONS "${COMPILER_OPTIONS} --debug")
endif()


add_subdirectory(libs)



add_subdirectory(src)
add_subdirectory(Drivers)



message(STATUS "----------------LEWY BUILD SYSTEM - INFO----------------")
message(STATUS "System Processor      : ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS
    "BUILD CONFIGURATION: ${CMAKE_BUILD_TYPE}\n"
    "---optimization level : ${OPTI_FLAG}\n"
    "---libs:\n"
    "libopencm3       :${LIBOPENCM3_INC_DIR}\n"
    "freeRTOS         :${FREERTOS_INC_DIR}\n"
    "BUILD FLAGS:\n"
    "[STM32_DEFINES]    ${STM32_DEFINES}\n"
    "[c flags]          ${CMAKE_C_FLAGS}\n"
    # "[c++ flags]        ${CMAKE_CXX_FLAGS}\n"
    # "[asm flags]        ${CMAKE_ASM_FLAGS}\n"
    # "[ld flags]         ${CMAKE_EXE_LINKER_FLAGS}\n"
    

)
message(STATUS "------------------------------------------------------")