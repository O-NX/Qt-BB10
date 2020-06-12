CONFIG +=  cross_compile compile_examples slog2 qqnx_pps qpa largefile precompile_header neon pcre
QT_BUILD_PARTS += libs
QT_NO_DEFINES =  CUPS DBUS EGLFS EVENTFD GLIB HARFBUZZ IMAGEFORMAT_JPEG MREMAP NIS OPENVG PULSEAUDIO STYLE_GTK XRENDER ZLIB
QT_QCONFIG_PATH = 
host_build {
    QT_CPU_FEATURES.x86_64 =  mmx sse sse2
} else {
    QT_CPU_FEATURES.arm = 
}
QT_COORD_TYPE = double
QT_LFLAGS_ODBC   = -lodbc
styles += mac fusion windows
DEFINES += QT_NO_MTDEV
QMAKE_CFLAGS_FONTCONFIG = 
QMAKE_LIBS_FONTCONFIG = -lfreetype -lfontconfig
DEFINES += QT_NO_LIBUDEV
DEFINES += QT_NO_EVDEV
DEFINES += QT_NO_XCB
DEFINES += QT_NO_XKBCOMMON
JAVASCRIPTCORE_JIT = no
sql-drivers = 
sql-plugins =  sqlite
