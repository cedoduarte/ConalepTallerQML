cmake_minimum_required(VERSION 3.16)

project(JuegoGato VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package(Qt6 6.4 REQUIRED COMPONENTS QuickControls2)

qt_standard_project_setup()

qt_add_executable(appJuegoGato
    main.cpp
    juegoutil.h juegoutil.cpp
)

qt_add_qml_module(appJuegoGato
    URI JuegoGato
    VERSION 1.0
    QML_FILES Main.qml Square.qml
)

set_target_properties(appJuegoGato PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appJuegoGato
    PRIVATE Qt6::Quick
)
target_link_libraries(appJuegoGato
    PRIVATE Qt6::QuickControls2
)

install(TARGETS appJuegoGato
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
