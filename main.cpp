#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include "data/stepmanager.h"
#include "data/custommodfunctions.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    // Allow QML file read to get data from JSON files
    qputenv("QML_XHR_ALLOW_FILE_READ", "1");

    // stepManager context to track on which step we are, and which options have been chosen.
    StepManager *stepManager = new StepManager;
    CustomModFunctions *customModFunctions = new CustomModFunctions;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    engine.rootContext()->setContextProperty("stepManager", stepManager);
    engine.rootContext()->setContextProperty("thisModCxx", customModFunctions);

    return app.exec();
}
