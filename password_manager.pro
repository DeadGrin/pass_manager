QT += quick

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        controlbuttons.cpp \
        main.cpp \
        operatingfiles.cpp \
        qaesencryption.cpp \
        sha256.cpp \
        tablemodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    aesni/aesni-enc-cbc.h \
    aesni/aesni-enc-ecb.h \
    aesni/aesni-key-exp.h \
    controlbuttons.h \
    operatingfiles.h \
    qaesencryption.h \
    sha256.h \
    tablemodel.h

DISTFILES += \
    KEYSHA256.txt \
    passwords/test.txt \
    passwords/test2.txt \
    passwords/test3.txt
