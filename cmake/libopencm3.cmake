set(LIBOPENCM3_DIR ${CMAKE_SOURCE_DIR}/libs/libopencm3)
set(LIBOPENCM3_INC_DIR ${LIBOPENCM3_DIR}/include)

add_custom_target(libopencm3
    COMMAND make -j8 TARGETS=stm32/f1 all
    WORKING_DIRECTORY ${LIBOPENCM3_DIR})

link_directories(${LIBOPENCM3_DIR}/lib)
include_directories(${LIBOPENCM3_INC_DIR})


set(LIBOPENCM3_LIB opencm3_stm32f1)

set(LINKER_FILE "${LIBOPENCM3_DIR}/lib/stm32/f1/stm32f103x8.ld")



set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --static -nostartfiles ")

set(LIBOPENCM3_LINKER_FLAGS " --static -nostartfiles ")

set(EXTERNAL_LIBS ${EXTERNAL_LIBS} ${LIBOPENCM3_LIB})

set(EXTERNAL_DEPENDENCIES ${EXTERNAL_DEPENDENCIES} libopencm3)

set(EXTERNAL_EXECUTABLES ${EXTERNAL_EXECUTABLES})# opencm3.c)
