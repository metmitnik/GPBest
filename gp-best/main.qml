import QtQuick 2.12
import QtQuick.Controls 2.5
import GBAPI 1.0

ApplicationWindow {
    id:app;
    width: 888/2
    height: 1824/2
    visible: true
    color:  "#5C455C";

    property string local : "local";
    property string title1 : "title1";
    property string title2 : "title2";
    property string mainCatalog : "mainCatalog";
    property string mainPrivacy : "mainPrivacy";
    property string mainAbout : "mainAbout";
    property string btnBack : "btnBack";
    property string btnMore : "btnMore";
    property string btnInstall : "btnInstall";
    property string btnCatalog : "btnCatalog";
    property string btnSimilar : "btnSimilar";
    property string infoTotalReviews : "infoTotalReviews";
    property string infoMb : "infoMb";
    property string infoInstalls : "infoInstalls";

    property int selectedIndex: 0;

    ListModel {
        id:catalogModel;
    }

        Component.onCompleted: {
            api.init();
        }

        function parseUpdate(){
            let labels = JSON.parse(api.labels);
            app.updateLabels(labels);

            catalogModel.clear();

            let catalogJson = JSON.parse(api.catalog);
            for(let i in catalogJson){
                catalogModel.append(catalogJson[i])
            }
            catalog.updateListHeight();
            //catalog.catalogModel = catalog;

            app.show("main");

        }

        function updateLabels(labels){
            mainScreen.title1Text = labels[app.title1];
            mainScreen.title2Text = labels[app.title2];
            mainScreen.buttonLabel = labels[app.mainCatalog];
            mainScreen.aboutLabel = labels[app.mainAbout];
            mainScreen.policyLabel = labels[app.mainPrivacy];

            gamesList.installsLb = labels[app.infoInstalls];
            gamesList.backLb = labels[app.btnBack];
            gamesList.moreLb = labels[app.btnMore];

            gameScreen.installLb = labels[app.btnInstall];
            gameScreen.backLb = labels[app.btnBack];
            gameScreen.catalogLb = labels[app.btnCatalog];
        }

    GBAPI {
        id:api;
        onUpdatesChanged: {app.parseUpdate()}

    }
    Image {
        id: name
        anchors.fill: parent;
        fillMode: Image.PreserveAspectCrop
        transformOrigin: Item.Center
        mipmap: true
        source: "qrc:/assets/bg1.jpg"
    }

    MainScreen {
        id:mainScreen
        anchors.fill: parent;
        onCatalogClick: {show("catalog")}
        visible: false;



    }

    CatalogScreen {
        id:catalog
        anchors.fill: parent;
        catalogModel: catalogModel;
        visible: false;


         onClicked: {
             selectedIndex = index;
             console.log("!@@", catalogModel.get(index).gamesFull);

             gamesList.updateMainModel(catalogModel.get(index).gamesFull);
           //  gamesList.gamesModel = ;
             show("gamesList")

         }

    }

    GamesListScreen {
        id:gamesList;
        anchors.fill: parent;
        visible: false;
        onBack: {show("catalog")}
        onGameClicked: {
            let o = JSON.parse(gameJson);
            console.log(gameJson);



            gameScreen.initData(o);
            show("gameScreen");

        }
    }

    GameScreen {
        id: gameScreen;
        anchors.fill: parent;
        visible: false;
        onGoBack: {
           //  gamesList.updateMainModel(catalogModel.get(selectedIndex).gamesFull);
            show("gamesList")
        }
        onGoCatalog: {show("catalog")}
    }

    function hideAll(){
        mainScreen.visible = catalog.visible = gamesList.visible = gameScreen.visible =  false;
    }

    function show(type){
        hideAll();
        switch (type){
        case "main":
            mainScreen.visible = true;
            break;
        case "catalog":
            catalog.visible = true;
            break;
        case "gamesList":
            gamesList.visible = true;
            break;
        case "gameScreen":
            gameScreen.visible = true;
            break;

        }
    }




}
