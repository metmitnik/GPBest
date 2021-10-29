#ifndef GBAPI_H
#define GBAPI_H

#include <QObject>
#include "UpdateManager.h"

class GBAPI : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(QString updates READ updates  NOTIFY updatesChanged);
    Q_PROPERTY(QString labels READ labels);
    Q_PROPERTY(QString catalog READ catalog);
    UpdateManager *umanager = nullptr;
    explicit GBAPI(QObject *parent = nullptr);

    Q_INVOKABLE void init();


    QString updates();
    QString labels();
    QString catalog();


signals:
    void initUManager();
    void updateUManager();
    void updatesChanged();

private slots:
    void onUpdatesReady();


};

#endif // GBAPI_H
