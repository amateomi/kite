cmake_minimum_required(VERSION 3.24.0)

project(
    kite
    VERSION 0.0.1
    DESCRIPTION "Simple web browser based on Qt"
    HOMEPAGE_URL "https://github.com/amateomi/kite"
    LANGUAGES CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

add_subdirectory(src)
