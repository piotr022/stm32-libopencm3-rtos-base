set(NAME app)

add_library(${NAME} STATIC)

target_include_directories(${NAME} PUBLIC
    include
)

target_sources(${NAME} PRIVATE
    include/app.hpp

    src/app_dummy.cpp
)

target_link_libraries(${NAME} PUBLIC
opencm3_stm32f1
)

target_compile_definitions(${NAME} PRIVATE
        -DSTM32F1
        -DSTM32F103xx
        -DSTM32
        -DSTM32F10X_HD
)
