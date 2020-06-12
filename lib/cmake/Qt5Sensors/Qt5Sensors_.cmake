
add_library(Qt5:: MODULE IMPORTED)

_populate_Sensors_plugin_properties( RELEASE "sensors/libqtsensors_blackberry.so")

list(APPEND Qt5Sensors_PLUGINS Qt5::)
