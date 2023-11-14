#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qputenv("QML_XHR_ALLOW_FILE_READ", "1");

    QQmlApplicationEngine engine;

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(QUrl::fromLocalFile("SIA/Main.qml"));

    return app.exec();
}
