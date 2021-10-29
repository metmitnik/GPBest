#include "GBAPI.h"

GBAPI::GBAPI(QObject *parent) : QObject(parent)
{

}

void GBAPI::init()
{
    if(umanager == nullptr){
        umanager = new UpdateManager(nullptr);
        QThread *th = new QThread();
        umanager->moveToThread(th);

        connect(this, &GBAPI::initUManager,   umanager, &UpdateManager::init);
        connect(this, &GBAPI::updateUManager, umanager, &UpdateManager::getUpdate);

        connect(umanager, &UpdateManager::updateReady, this, &GBAPI::onUpdatesReady);

        th->start();

        emit initUManager();
        emit updateUManager();
    }
}

QString GBAPI::updates()
{
    QJsonDocument Doc(umanager->updateJSON);
    QByteArray ba = Doc.toJson();
    return QString(ba);
}

QString GBAPI::labels()
{
    QJsonDocument Doc(umanager->labels);
    QByteArray ba = Doc.toJson();
    return QString(ba);
}

QString GBAPI::catalog()
{
    QJsonDocument Doc(umanager->catalog);
    QByteArray ba = Doc.toJson();
    return QString(ba);
}

void GBAPI::onUpdatesReady()
{
    emit updatesChanged();
}
