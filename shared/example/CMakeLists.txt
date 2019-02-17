cmake_minimum_required(VERSION 3.2)

project(Example)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE CACHE BOOL "")

find_package(ParaView REQUIRED)
include(${ParaView_USE_FILE})

add_paraview_plugin(ExamplePlugin 1.0
    SERVER_MANAGER_XML ExamplePlugin.xml
    SERVER_MANAGER_SOURCES "ExamplePlugin.cpp")

install(TARGETS ExamplePlugin DESTINATION /usr/lib/paraview/plugins)

set(CPACK_GENERATOR "DEB")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Lutz Hofmann")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "1")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "paraview")
set(CPACK_PACKAGE_DESCRIPTION "Example paraview plugin")

include(CPack)

