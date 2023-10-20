cmake_minimum_required(VERSION 3.16)

project(Graficas VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package(Qt6 6.4 REQUIRED COMPONENTS QuickControls2)
find_package(Qt6 6.4 REQUIRED COMPONENTS Charts)

qt_standard_project_setup()

qt_add_executable(appGraficas
    main.cpp
)

qt_add_qml_module(appGraficas
    URI Graficas
    VERSION 1.0
    QML_FILES Main.qml
    Plot1.qml
    Plot2.qml
    Plot3.qml
    Plot4.qml
)

set_target_properties(appGraficas PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appGraficas
    PRIVATE Qt6::Quick
)
target_link_libraries(appGraficas
    PRIVATE Qt6::QuickControls2
)
target_link_libraries(appGraficas
    PRIVATE Qt6::Charts
)

install(TARGETS appGraficas
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
