import QtQuick 2.15

Item {
    id:button;
    property alias fontSize: label.font.pixelSize;
    property alias labelText: label.text;
    property alias buttonColor: rect.color;

    signal clicked();
    FontLoader { id: loclaFont; source: "qrc:/assets/comic.ttf" }

    Rectangle {

        anchors.fill: parent;
        color: "#000028"

        radius: 5;

    }

    Timer {
        id:timer;
        interval: 1000;
        repeat: false;
        onTriggered: {
         button.opacity = 1;
        }
    }

    Rectangle {
        id:rect
        anchors.fill: parent;
     //   color: "#00e6dc"
//        MouseArea {
//            onPressed: {rect.color = "#009999"; label.color = "#ffffff";}
//            onReleased:  {rect.color = "#00e6dc"; label.color = "#000028";  button.clicked()}
//            onExited: {rect.color = "#00e6dc"; label.color = "#000028"}
//            anchors.fill: parent
//            hoverEnabled: true;
//            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor

//        }
        radius: 5;

        border.color: "#daede6"//"#6bbdbb"

        MouseArea {
            onPressed: {button.opacity = 0.7; timer.start();}
            onReleased:  {button.opacity = 1; button.clicked(); console.log(rect.color)}
            onExited: {button.opacity = 1;}
           // onDragChanged: {button.opacity = 1;}


            anchors.fill: parent


        }


    }

    TextMetrics {
        id:textMetricks
        font.family: loclaFont.name;
        elide: "ElideRight";
        elideWidth: label.width;
    }




    Text {
        id:label
        font.family: loclaFont.name;

        font.bold: true;
        font.pixelSize: parent.height*0.28
        color: "#1c2421";
        textFormat: Text.RichText;

       //text: "My folders"

        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;

        anchors.fill: parent;
        wrapMode: Text.WordWrap;

    }



}
