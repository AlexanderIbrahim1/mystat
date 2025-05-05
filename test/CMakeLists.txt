cmake_minimum_required(VERSION 3.14)

project(mystatTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(mystat REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(mystat_test source/mystat_test.cpp)
target_link_libraries(mystat_test PRIVATE mystat::mystat)
target_compile_features(mystat_test PRIVATE cxx_std_20)

add_test(NAME mystat_test COMMAND mystat_test)

# ---- End-of-file commands ----

add_folders(Test)
