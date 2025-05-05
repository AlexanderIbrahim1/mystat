cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    mystat
    VERSION 0.1.0
    DESCRIPTION "An example of a static library"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    mystat_mystat
    source/mystat.cpp
)
add_library(mystat::mystat ALIAS mystat_mystat)

include(GenerateExportHeader)
generate_export_header(
    mystat_mystat
    BASE_NAME mystat
    EXPORT_FILE_NAME export/mystat/mystat_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(mystat_mystat PUBLIC MYSTAT_STATIC_DEFINE)
endif()

set_target_properties(
    mystat_mystat PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME mystat
    OUTPUT_NAME mystat
)

target_include_directories(
    mystat_mystat ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    mystat_mystat SYSTEM
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(mystat_mystat PUBLIC cxx_std_20)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${mystat_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT mystat_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of mystat"
  )
endif()

include(cmake/dev-mode.cmake)
