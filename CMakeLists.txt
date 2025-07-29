cmake_minimum_required(VERSION 3.10)
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# PC上安装的交叉编译器路径（确保已经安装）
set(CMAKE_C_COMPILER /usr/bin/arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER /usr/bin/arm-linux-gnueabihf-g++)
# Set the minimum required version of CMake
set(CMAKE_SYSROOT /root/board_sysroot)

# 交叉编译时查找头文件和库的路径
set(CMAKE_FIND_ROOT_PATH ${CMAKE_SYSROOT})

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)  # 本机程序用本机编译器，不从 sysroot 查找
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)


set(CMAKE_CROSSCOMPILING TRUE)


# 获取目录名
get_filename_component(CUR_DIR_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)
message("当前源代码目录名：${CUR_DIR_NAME}")

project(CUR_DIR_NAME)

set(CMAKE_CXX_STANDARD 14)

add_executable(${CMAKE_PROJECT_NAME} src/main.cpp)

find_package(OpenCV REQUIRED)


if(OpenCV_FOUND)
    include_directories(${OpenCV_INCLUDE_DIRS})
    target_link_libraries(${CMAKE_PROJECT_NAME} ${OpenCV_LIBS})
else()
    message(FATAL_ERROR "OpenCV not found")
endif()
