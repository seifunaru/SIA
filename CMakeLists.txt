cmake_minimum_required(VERSION 3.16)

project(SIA VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AURORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Core Gui Network OpenGL Pdf PdfQuick Qml QmlLocalStorage QmlModels QmlWorkerScript QmlXmlListModel Quick3DUtils QuickControls2 QuickControls2Impl QuickDialogs2 QuickDialogs2QuickImpl QuickDialogs2Utils QuickLayouts QuickTemplates2 QuickTimeline ShaderTools Sql Svg)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appSIA
    main.cpp
    data/stepmanager.cpp
)

qt_add_qml_module(appSIA
    URI SIA
    VERSION 1.0
    QML_FILES
        Main.qml
        data/qml/themes/ThemeManager.qml
        data/qml/appControls/Button_solidSwap.qml
        data/qml/appControls/ParallaxImage.qml
        data/qml/appControls/LodImage.qml
        data/qml/pageStyle/BasicIntroPage.qml
        data/qml/pageStyle/Step_ToggleMaker.qml
        data/qml/pageStyle/Step_ConfirmInstallation.qml
)

set_target_properties(appSIA PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSIA
    PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt6::Gui
    Qt6::Network
    Qt6::OpenGL
    Qt6::Pdf
    Qt6::PdfQuick
    Qt6::Qml
    Qt6::QmlLocalStorage
    Qt6::QmlModels
    Qt6::QmlWorkerScript
    Qt6::QmlXmlListModel
    Qt6::Quick3DUtils
    Qt6::QuickControls2
    Qt6::QuickControls2Impl
    Qt6::QuickDialogs2
    Qt6::QuickDialogs2QuickImpl
    Qt6::QuickDialogs2Utils
    Qt6::QuickLayouts
    Qt6::QuickTemplates2
    Qt6::QuickTimeline
    Qt6::ShaderTools
    Qt6::Sql
    Qt6::Svg
)

install(TARGETS appSIA
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
