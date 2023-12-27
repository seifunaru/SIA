#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include "data/stepManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Allow QML file read to get data from JSON files
    qputenv("QML_XHR_ALLOW_FILE_READ", "1");

    // stepManager context to track on which step we are, and which options have been chosen.
    StepManager *stepManager = new StepManager;

    QQmlApplicationEngine engine;

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(QUrl::fromLocalFile("SIA/Main.qml"));

    engine.rootContext()->setContextProperty("stepManager", stepManager);

    return app.exec();
}
