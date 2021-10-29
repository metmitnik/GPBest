#ifndef UPDATEMANAGER_H
#define UPDATEMANAGER_H

#include <QObject>
#include <QtNetwork>
#include <QJsonArray>
#include <QJsonObject>


class UpdateManager : public QObject
{
    Q_OBJECT
public:
    QJsonObject updateJSON;
    QJsonObject labels;
    QJsonArray catalog;
    QHash<QString, QJsonObject> games;
    QNetworkReply *repl;
    QNetworkAccessManager *manager = nullptr;

    bool isInit;
    QString host = "http://18.116.133.93:8000/pg_as_best";
//giveaway/content/getAllByLocalHl?LocalHl=es;

    explicit UpdateManager(QObject *parent = nullptr);

private:
    bool parseUpdate(QString data);


signals:
    void updateReady();

private slots:
    void onUpdateResult();
    void onUpdateFalse();
public slots:
    void init();
    void getUpdate();

};

#endif // UPDATEMANAGER_H
