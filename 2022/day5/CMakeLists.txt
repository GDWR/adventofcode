cmake_minimum_required(VERSION 3.24)
project(aoc_2022 C)

set(CMAKE_C_STANDARD 23)

add_executable(aoc_2022
        src/main.c
        src/stack.c src/stack.h
)
