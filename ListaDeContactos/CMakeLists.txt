cmake_minimum_required(VERSION 3.16)

project(ListaDeContactos VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package(Qt6 6.4 REQUIRED COMPONENTS QuickControls2)

qt_standard_project_setup()

qt_add_executable(appListaDeContactos
    main.cpp
)

qt_add_qml_module(appListaDeContactos
    URI ListaDeContactos
    VERSION 1.0
    QML_FILES Main.qml
    AddContact.qml
    EditContact.qml
    DeleteContact.qml
    ContactList.qml
    ContactEditorPage.qml
)

set_target_properties(appListaDeContactos PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appListaDeContactos
    PRIVATE Qt6::Quick
)
target_link_libraries(appListaDeContactos
    PRIVATE Qt6::QuickControls2
)

install(TARGETS appListaDeContactos
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
