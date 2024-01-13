QT += quick

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        data/stepmanager.cpp \
        data/custommodfunctions.cpp

HEADERS += \
    data/stepmanager.h \
    data/custommodfunctions.h

RESOURCES += \
    res.qrc

RC_ICONS = AppLogo.ico

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target



# CQTDEPLOY
QT_DIR= $$[QT_HOST_BINS]
win32:QMAKE_BIN= $$QT_DIR/qmake.exe
contains(QMAKE_HOST.os, Linux):{
    QMAKE_BIN= $$QT_DIR/qmake
}

DESTDIR=$$PWD/Build

deploy.commands= cqtdeployer -bin $$DESTDIR/$$TARGET -qmake $$QMAKE_BIN -libDir $$PWD -qmlDir $$PWD -recursiveDepth 5

QMAKE_EXTRA_TARGETS += deploy

