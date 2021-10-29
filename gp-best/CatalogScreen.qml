import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    id:root;

    FontLoader { id: loclaFont; source: "qrc:/assets/comic.ttf" }


    property alias catalogModel: list.model;
    signal clicked(int index);

//    ListModel {
//        id:catalogModel;
//           ListElement {
//               name : "Most Popular"
//           }
//           ListElement {
//               name : "Casual"
//           }
//           ListElement {
//               name : "Puzzle"
//           }
//           ListElement {
//               name : "Race"
//           }
//           ListElement {
//               name : "RPG"
//           }
//    }

    function updateListHeight(){
        list.height = list.model.count*(60+15);
        if(list.height > listParent.height){
         list.height = listParent.height - 75
        }
    }
    Item {

        id:listParent;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: adMobeContainer.top;
        anchors.topMargin: 75;

        ListView {
            id:list
            onModelChanged: {
                console.log("------------------------",model.count);
                list.height = model.count*(60+15);

                if(list.height > parent.height){
                 list.height = parent.height
                }
            }
            clip: true;

            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;
            width: parent.width*0.7;
            height: model.count*(60+15);


            model: catalogModel;
            spacing: 15;

            delegate: RoundButton {
                width: list.width;
                height: 60;
                labelText: genre
                 buttonColor: "#72cdcb"
                 onClicked: root.clicked(index);

            }

        }

    }



    Item {
        id:adMobeContainer
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        height: 75;


    }

}
