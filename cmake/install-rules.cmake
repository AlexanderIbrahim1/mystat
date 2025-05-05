if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/mystat-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package mystat)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT mystat_Development
)

install(
    TARGETS mystat_mystat
    EXPORT mystatTargets
    RUNTIME #
    COMPONENT mystat_Runtime
    LIBRARY #
    COMPONENT mystat_Runtime
    NAMELINK_COMPONENT mystat_Development
    ARCHIVE #
    COMPONENT mystat_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    mystat_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE mystat_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(mystat_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${mystat_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT mystat_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${mystat_INSTALL_CMAKEDIR}"
    COMPONENT mystat_Development
)

install(
    EXPORT mystatTargets
    NAMESPACE mystat::
    DESTINATION "${mystat_INSTALL_CMAKEDIR}"
    COMPONENT mystat_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
