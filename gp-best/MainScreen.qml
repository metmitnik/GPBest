import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    property alias title1Text: title1.text;
    property alias title2Text: title2.text;
    property alias buttonLabel: btn.labelText;
    property alias aboutLabel: aboutLink.text;
    property alias policyLabel: policyLink.text;

    FontLoader { id: loclaFont; source: "qrc:/assets/comic.ttf" }


    id:screen;

    signal catalogClick();

    Item {
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.top: parent.top;
        anchors.bottom: btn.top;

        Text {
            id: title1
            font.family: loclaFont.name;
//            anchors.bottom: title2.top;
//            anchors.topMargin: parent.height*0.2;
//            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.centerIn: parent;
            width: parent.width*0.9;


        //    Layout.alignment: Qt.AlignCenter
         //   Layout.preferredHeight: 40;
              font.pixelSize: 22//screen.width*0.5*0.3*0.3;
              color: "#ffffff"
          //  text: qsTr("Looking for Best & Most popular Games?");
              wrapMode: Text.WordWrap
             horizontalAlignment: Text.AlignHCenter;
        }


        Text {
            id: title2
              font.family: loclaFont.name;
            anchors.top: title1.bottom;
//            anchors.bottomMargin: Math.max(parent.height*.3, 5)
            anchors.horizontalCenter: parent.horizontalCenter;
        //     Layout.preferredHeight: 40;
         //   Layout.alignment: Qt.AlignCenter
            font.pixelSize: 22//screen.width*0.5*0.3*0.3;
            color: "#ffffff"
        //    text: qsTr("Check our Catalog!")
             horizontalAlignment: Text.AlignHCenter;
        }

    }




    RoundButton {
        id:btn
        anchors.centerIn: parent;
        width: screen.width*0.6;
        height: screen.height*0.11;
        buttonColor: "#72cdcb";
        onClicked: screen.catalogClick();

    //    labelText: qsTr("Category Catalog");

    }

    Text {
          font.family: loclaFont.name;
        id: policyLink
        anchors.bottom: aboutLink.top;
        anchors.horizontalCenter: parent.horizontalCenter;
    //     Layout.preferredHeight: 40;
     //   Layout.alignment: Qt.AlignCenter
        font.pixelSize: 22;
        font.underline: true;
        color: "#6da4fc"
      //  text: qsTr("Privacy policy")
         horizontalAlignment: Text.AlignHCenter;

         MouseArea {
             anchors.fill: parent;
             onPressed: {Qt.openUrlExternally("https://play.google.com/store/apps/details?id=com.tocaboca.tocalifeworld&hl=en&gl=US") }
         }

    }


    Text {
          font.family: loclaFont.name;
        id: aboutLink
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
    //     Layout.preferredHeight: 40;
     //   Layout.alignment: Qt.AlignCenter
        font.pixelSize: 22;
        font.underline: true;
        color: "#6da4fc"
      //  text: qsTr("About")
         horizontalAlignment: Text.AlignHCenter;

         MouseArea {
             anchors.fill: parent;
             onPressed: {Qt.openUrlExternally("https://play.google.com/store/apps/details?id=com.tocaboca.tocalifeworld&hl=en&gl=US") }
         }

    }


}
