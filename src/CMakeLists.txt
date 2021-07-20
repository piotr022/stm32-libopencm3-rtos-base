
include_directories(inc)

set(LINKER_SCRIPT_LOC ${CMAKE_SOURCE_DIR}/src/stm32f103xe.ld) #real one

SET(CMAKE_C_FLAGS "${COMPILER_OPTIONS} -lm -lc -lnosys --specs=nosys.specs " CACHE INTERNAL "c compiler flags")
SET(CMAKE_CXX_FLAGS "${COMPILER_OPTIONS} -lm -lc -lnosys --specs=nosys.specs " CACHE INTERNAL "cxx compiler flags")
SET(CMAKE_ASM_FLAGS "${COMPILER_OPTIONS}" CACHE INTERNAL "asm compiler flags")

SET(CMAKE_EXE_LINKER_FLAGS "${COMPILER_OPTIONS} -T ${LINKER_SCRIPT_LOC} -Wl,-Map=linker.map -Wl,-cref -Wl,--print-memory-usage -Wl,--gc-sections ${LIBOPENCM3_LINKER_FLAGS}" CACHE INTERNAL "exe link flags")


file(GLOB C_SOURCE
startup_stm32f10x_hd.s
system_stm32f10x.c
opencm3.c
main.c
stm32f1xx_it.c
stm32f1xx_it.h
# stm32f1xx_it.c
# stm32f1xx_it.h
# system_stm32f10x.c
# startup_stm32f10x_hd.s 
)



add_executable(${EXECUTABLE}  
        ${C_SOURCE}
        ${EXTERNAL_EXECUTABLES}
)



add_dependencies(${EXECUTABLE}
libopencm3
)


target_link_libraries(${EXECUTABLE}
${EXTERNAL_LIBS}
)

target_compile_definitions(${EXECUTABLE} PRIVATE
        ${STM32_DEFINES}
        # -DSTM32F1
        # -DSTM32F103xx
        # -DSTM32
        # -DSTM32F10X_HD
)



add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND arm-none-eabi-size ${EXECUTABLE}
)
#convert to hex
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND arm-none-eabi-objcopy -O ihex ${EXECUTABLE} ${PROJECT_NAME}.hex
        COMMAND arm-none-eabi-objcopy -O binary ${EXECUTABLE} ${PROJECT_NAME}.bin
)

