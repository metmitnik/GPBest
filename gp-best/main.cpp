#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "GBAPI.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif


    qDebug() << "QSslSocket::sslLibraryBuildVersionString()" << QSslSocket::sslLibraryBuildVersionString();
    qDebug() << "QSslSocket::sslLibraryVersionString()" << QSslSocket::sslLibraryVersionString();
    qDebug() << "Supports SSL: " << QSslSocket::supportsSsl();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

     qmlRegisterType<GBAPI>("GBAPI", 1, 0, "GBAPI");

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
