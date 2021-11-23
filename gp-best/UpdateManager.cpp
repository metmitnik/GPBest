#include "UpdateManager.h"

UpdateManager::UpdateManager(QObject *parent) : QObject(parent)
{
// QFile file(Globals::STORAGE_PATH+"/" + Globals::DEV_TOKEN_FILE_NAME);
//    if(file.open(QIODevice::WriteOnly | QIODevice::Text)){
//        file.write(deviceToken.toUtf8());

 //   }
}

bool UpdateManager::parseUpdate(QString data)
{
    QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8());
    QJsonObject json = doc.object();

    if(json.contains("ident")){

        ident = json["ident"].toString();

         QFile file(path);
            if(file.open(QIODevice::WriteOnly)){
                file.write(ident.toUtf8());
                file.close();

            }

        getUpdate();

        return true;
    }

    labels = json.value("labels").toObject();

    updateJSON = json;

    QJsonDocument d(labels);
    QByteArray ba = d.toJson();

    qDebug() <<  QString(ba);

    QJsonArray _games = json.value("games").toArray();

    for (auto v : _games) {
        QJsonObject _game = v.toObject();
        if(_game.value("name").toString() != ""){
//            QString desc = _game.value("desc").toString();
//            if(desc.length() > 250){
//                desc = desc.left(250);


//            }
//            _game.insert("desc",desc);
            QString stars = _game.value("stars").toString();
            QRegularExpression re(".*(\\d.\\d\\d?).*");
            stars =  re.match(stars).captured(1);

            _game.insert("stars",stars);

            QString size = _game.value("size").toString();
             QRegularExpression re2("\\d{1,6}.");


             QRegularExpressionMatch m = re2.match(size);



             if(!m.hasMatch()){

                 size = " ";
                _game.insert("size",size);
             }

             QJsonArray screenshots = _game.value("screenshots").toArray();
             QJsonArray _srcs;
                for (auto v : screenshots) {
                    QJsonObject o;
                    o.insert("src", v.toString());
                    _srcs.push_back(o);

                }

                 _game.insert("screenshots",_srcs);


            games[_game.value("id").toString()] = _game;
        }else{
            qDebug() << "upds";

        }
    }


    QJsonArray _catalog = json.value("catalog").toArray();
    while(catalog.count()) {
        catalog.pop_back();
    }

    for (auto v : _catalog) {
        QJsonObject item = v.toObject();
        QJsonArray gms = item.value("games").toArray();
        QJsonArray gmsJson;
        for (auto vv : gms){
            QString id = vv.toString();
            if(games.contains(id)){
                gmsJson.push_back(games.value(id));
            } else {
                qDebug() << "---- " << id;
            }
        }
        item.insert("gamesFull", gmsJson);

        catalog.push_back(item);



    }

    emit updateReady();


    return true;
}


void UpdateManager::init()
{
    qDebug() << "init update manager";
    manager = new QNetworkAccessManager(this->parent());

    path = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation)+"/GPBest";

    QDir d(path);
    if (!d.exists()) {
        d.mkdir(".");
    }

    path += "/ident.token";

     QFile file(path);
     if(file.exists()){
         if(file.open(QIODevice::ReadOnly)){
             ident = file.readAll();
             file.close();

         }
     }


}

void UpdateManager::getUpdate()
{
    QLocale systemLocale = QLocale::system();
    //  systemLocale.languageToString(systemLocale.language()).languageToString(systemLocale.language());
    //giveaway/content/getAllByLocalHl?LocalHl=es;
    QString lang = systemLocale.uiLanguages()[0].split("-")[0];

    QString url = host + "/giveaway/content/getAllByLocalHl?LocalHl="+ lang + "&ident="+ident;

    qDebug() << "send to "<<url<<systemLocale.uiLanguages()[0].split("-")[0];
    QNetworkRequest req;
    req.setUrl(url);

    repl = manager->get(req);

    connect(repl, & QNetworkReply::finished, this, &UpdateManager::onUpdateResult);
    connect(repl, &QNetworkReply::sslErrors,this, &UpdateManager::onUpdateFalse);

}



void UpdateManager::onUpdateResult()
{
    qDebug() << "Response handler";
    QVariant statusCode = repl->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qint32 code = statusCode.toInt();

    QString errorString = "";

    if(  repl->error() != repl->NoError){
        errorString = repl->errorString();
        qDebug() <<repl->error() <<errorString;
    }

    bool result = false;


    qDebug() << repl->url();
    qDebug() << "response code: " + QString::number(code) +" size: "+ QString::number(repl->size());

    if(code == 200){
        result = parseUpdate(repl->readAll());

    }


}

void UpdateManager::onUpdateFalse()
{

}
