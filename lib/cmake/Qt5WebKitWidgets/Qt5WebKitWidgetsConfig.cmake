
if (CMAKE_VERSION VERSION_LESS 2.8.3)
    message(FATAL_ERROR "Qt 5 requires at least CMake version 2.8.3")
endif()

get_filename_component(_qt5WebKitWidgets_install_prefix "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# For backwards compatibility only. Use Qt5WebKitWidgets_VERSION instead.
set(Qt5WebKitWidgets_VERSION_STRING 5.2.2)

set(Qt5WebKitWidgets_LIBRARIES Qt5::WebKitWidgets)

macro(_qt5_WebKitWidgets_check_file_exists file)
    if(NOT EXISTS "${file}" )
        message(FATAL_ERROR "The imported target \"Qt5::WebKitWidgets\" references the file
   \"${file}\"
but this file does not exist.  Possible reasons include:
* The file was deleted, renamed, or moved to another location.
* An install or uninstall procedure did not complete successfully.
* The installation package was faulty and contained
   \"${CMAKE_CURRENT_LIST_FILE}\"
but not all the files it references.
")
    endif()
endmacro()


macro(_populate_WebKitWidgets_target_properties Configuration LIB_LOCATION IMPLIB_LOCATION)
    set_property(TARGET Qt5::WebKitWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS ${Configuration})

    set(imported_location "${_qt5WebKitWidgets_install_prefix}/lib/${LIB_LOCATION}")
    _qt5_WebKitWidgets_check_file_exists(${imported_location})
    set_target_properties(Qt5::WebKitWidgets PROPERTIES
        "INTERFACE_LINK_LIBRARIES" "${_Qt5WebKitWidgets_LIB_DEPENDENCIES}"
        "IMPORTED_LOCATION_${Configuration}" ${imported_location}
        "IMPORTED_SONAME_${Configuration}" "libQt5WebKitWidgets.so.5"
        # For backward compatibility with CMake < 2.8.12
        "IMPORTED_LINK_INTERFACE_LIBRARIES_${Configuration}" "${_Qt5WebKitWidgets_LIB_DEPENDENCIES}"
    )

endmacro()

if (NOT TARGET Qt5::WebKitWidgets)

    set(_Qt5WebKitWidgets_OWN_INCLUDE_DIRS "${_qt5WebKitWidgets_install_prefix}/include/" "${_qt5WebKitWidgets_install_prefix}/include/QtWebKitWidgets")
    set(Qt5WebKitWidgets_PRIVATE_INCLUDE_DIRS
        "${_qt5WebKitWidgets_install_prefix}/include/QtWebKitWidgets/5.2.2"
        "${_qt5WebKitWidgets_install_prefix}/include/QtWebKitWidgets/5.2.2/QtWebKitWidgets"
    )

    foreach(_dir ${_Qt5WebKitWidgets_OWN_INCLUDE_DIRS})
        _qt5_WebKitWidgets_check_file_exists(${_dir})
    endforeach()

    # Only check existence of private includes if the Private component is
    # specified.
    list(FIND Qt5WebKitWidgets_FIND_COMPONENTS Private _check_private)
    if (NOT _check_private STREQUAL -1)
        foreach(_dir ${Qt5WebKitWidgets_PRIVATE_INCLUDE_DIRS})
            _qt5_WebKitWidgets_check_file_exists(${_dir})
        endforeach()
    endif()

    set(Qt5WebKitWidgets_INCLUDE_DIRS ${_Qt5WebKitWidgets_OWN_INCLUDE_DIRS})

    set(Qt5WebKitWidgets_DEFINITIONS -DQT_WEBKITWIDGETS_LIB)
    set(Qt5WebKitWidgets_COMPILE_DEFINITIONS QT_WEBKITWIDGETS_LIB)

    set(_Qt5WebKitWidgets_MODULE_DEPENDENCIES "Quick;MultimediaWidgets;OpenGL;PrintSupport;WebKit;Widgets;Network;Sensors;Gui;Core")

    set(_Qt5WebKitWidgets_FIND_DEPENDENCIES_REQUIRED)
    if (Qt5WebKitWidgets_FIND_REQUIRED)
        set(_Qt5WebKitWidgets_FIND_DEPENDENCIES_REQUIRED REQUIRED)
    endif()
    set(_Qt5WebKitWidgets_FIND_DEPENDENCIES_QUIET)
    if (Qt5WebKitWidgets_FIND_QUIETLY)
        set(_Qt5WebKitWidgets_DEPENDENCIES_FIND_QUIET QUIET)
    endif()
    set(_Qt5WebKitWidgets_FIND_VERSION_EXACT)
    if (Qt5WebKitWidgets_FIND_VERSION_EXACT)
        set(_Qt5WebKitWidgets_FIND_VERSION_EXACT EXACT)
    endif()

    set(Qt5WebKitWidgets_EXECUTABLE_COMPILE_FLAGS "")

    foreach(_module_dep ${_Qt5WebKitWidgets_MODULE_DEPENDENCIES})
        if (NOT Qt5${_module_dep}_FOUND)
            find_package(Qt5${_module_dep}
                5.2.2 ${_Qt5WebKitWidgets_FIND_VERSION_EXACT}
                ${_Qt5WebKitWidgets_DEPENDENCIES_FIND_QUIET}
                ${_Qt5WebKitWidgets_FIND_DEPENDENCIES_REQUIRED}
                PATHS "${CMAKE_CURRENT_LIST_DIR}/.." NO_DEFAULT_PATH
            )
        endif()

        if (NOT Qt5${_module_dep}_FOUND)
            set(Qt5WebKitWidgets_FOUND False)
            return()
        endif()

        list(APPEND Qt5WebKitWidgets_INCLUDE_DIRS "${Qt5${_module_dep}_INCLUDE_DIRS}")
        list(APPEND Qt5WebKitWidgets_PRIVATE_INCLUDE_DIRS "${Qt5${_module_dep}_PRIVATE_INCLUDE_DIRS}")
        list(APPEND Qt5WebKitWidgets_DEFINITIONS ${Qt5${_module_dep}_DEFINITIONS})
        list(APPEND Qt5WebKitWidgets_COMPILE_DEFINITIONS ${Qt5${_module_dep}_COMPILE_DEFINITIONS})
        list(APPEND Qt5WebKitWidgets_EXECUTABLE_COMPILE_FLAGS ${Qt5${_module_dep}_EXECUTABLE_COMPILE_FLAGS})
    endforeach()
    list(REMOVE_DUPLICATES Qt5WebKitWidgets_INCLUDE_DIRS)
    list(REMOVE_DUPLICATES Qt5WebKitWidgets_PRIVATE_INCLUDE_DIRS)
    list(REMOVE_DUPLICATES Qt5WebKitWidgets_DEFINITIONS)
    list(REMOVE_DUPLICATES Qt5WebKitWidgets_COMPILE_DEFINITIONS)
    list(REMOVE_DUPLICATES Qt5WebKitWidgets_EXECUTABLE_COMPILE_FLAGS)

    set(_Qt5WebKitWidgets_LIB_DEPENDENCIES "Qt5::Quick;Qt5::MultimediaWidgets;Qt5::OpenGL;Qt5::PrintSupport;Qt5::WebKit;Qt5::Widgets;Qt5::Network;Qt5::Sensors;Qt5::Gui;Qt5::Core")

    add_library(Qt5::WebKitWidgets SHARED IMPORTED)

    set_property(TARGET Qt5::WebKitWidgets PROPERTY
      INTERFACE_INCLUDE_DIRECTORIES ${_Qt5WebKitWidgets_OWN_INCLUDE_DIRS})
    set_property(TARGET Qt5::WebKitWidgets PROPERTY
      INTERFACE_COMPILE_DEFINITIONS QT_WEBKITWIDGETS_LIB)

    _populate_WebKitWidgets_target_properties(RELEASE "libQt5WebKitWidgets.so.5.2.2" "" )







_qt5_WebKitWidgets_check_file_exists("${CMAKE_CURRENT_LIST_DIR}/Qt5WebKitWidgetsConfigVersion.cmake")

endif()
