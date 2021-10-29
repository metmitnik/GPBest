import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    id:root;
    FontLoader { id: loclaFont; source: "qrc:/assets/comic.ttf" }

    signal gameClicked(string gameJson);

    // property alias gamesModel: list.model;

    property string installsLb: "Installs";
    property alias moreLb: btnMore.labelText;
    property alias backLb: btnBack.labelText;


    signal back()

    property int currentIndex: 0;
    property int viewCount: 6;

    ListModel {
        id:mainModel;
    }
    ListModel {
        id:viewModel;
    }

    function updateMainModel(model){
        currentIndex = 0;
        //  mainModel = model;
        mainModel.clear();
        let i = 0;
        while(i < model.count){
            mainModel.append(model.get(i));
            i++;
        }
        updateViewModel();


    }

    function updateViewModel(){
        let i = viewCount;

        if(currentIndex + i > mainModel.count){
            i =  mainModel.count - currentIndex;
        }

        if(i <= 0){
            i = viewCount;
            currentIndex = 0;
        }

        viewModel.clear();

        while(i-- && currentIndex < mainModel.count){
            viewModel.append(mainModel.get(currentIndex));
            currentIndex++;
        }



    }

    //    ListModel {
    //        id:gamesModel;
    //           ListElement {
    //               name : "Game1"
    //               stars: "4.5";
    //               size: "190 mb"
    //               instals: "30000+Installs"
    //               pic: "qrc:/assets/icons/Warning.svg"
    //           }
    //           ListElement {
    //               name : "Game2"
    //               stars: "4.5";
    //               size: "190 mb"
    //               instals: "30000+Installs"
    //                pic: "qrc:/assets/icons/Warning.svg"
    //           }
    //           ListElement {
    //               name : "Game3"
    //               stars: "4.5";
    //               size: "190 mb"
    //               instals: "30000+Installs"
    //               pic: "qrc:/assets/icons/Warning.svg"
    //           }
    //           ListElement {
    //               name : "Game4"
    //               stars: "4.5";
    //               size: "190 mb"
    //               instals: "30000+Installs"
    //                pic: "qrc:/assets/icons/Warning.svg"
    //           }

    //    }

    ListView {
        id:list

        anchors.margins: 10;
        anchors.topMargin: 35;

        anchors.top: parent.top;
        anchors.bottom: uiHolder.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;

        clip:true;



        model: viewModel;
        spacing: 15;

        delegate: GamesListDelegate {
            width: list.width;
            height: 100;
            installsLb: root.installsLb
            onGameClicked: {
                root.gameClicked(gameJson)
            }


        }

    }



    Item {
        id:uiHolder;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        height: root.height*0.2;


        Item {
            id:adMobeContainer
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.right: parent.right;
            height: root.height*0.15;


        }


        RowLayout {
            anchors.bottom: parent.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            height: root.height*0.15;


            RoundButton {
                id:btnBack;
                Layout.alignment: Qt.AlignHCenter
                labelText: "Back"
                buttonColor: "#72cdcb"

                Layout.preferredWidth: 150;
                Layout.preferredHeight: 50;
                onClicked: {root.back()}

            }
            RoundButton {
                id:btnMore
                Layout.alignment: Qt.AlignHCenter
                labelText: "More"
                buttonColor: "#72cdcb"
                Layout.preferredWidth: 150;
                Layout.preferredHeight: 50;
                onClicked: {updateViewModel()}

            }

        }







    }

}
