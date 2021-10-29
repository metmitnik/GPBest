import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    property alias title1Text: title1.text;
    property alias title2Text: title2.text;
    id:screen;

     signal catalogClick();

    Text {
        id: title1
        anchors.top: parent.top;
        anchors.topMargin: parent.height*0.2;
        anchors.horizontalCenter: parent.horizontalCenter;

    //    Layout.alignment: Qt.AlignCenter
     //   Layout.preferredHeight: 40;
          font.pixelSize: 22;
          color: "#ffffff"
        text: qsTr("Looking for Best & Most popular Games?");
          wrapMode: Text.WordWrap
         horizontalAlignment: Text.AlignHCenter;
    }


    Text {
        id: title2
        anchors.top: title1.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
    //     Layout.preferredHeight: 40;
     //   Layout.alignment: Qt.AlignCenter
        font.pixelSize: 22;
        color: "#ffffff"
        text: qsTr("Check our Catalog!")
         horizontalAlignment: Text.AlignHCenter;
    }


    ColumnLayout {
        anchors.left: parent.left;
        anchors.right: parent.right;

        anchors.verticalCenter: parent.verticalCenter;


        height: parent.height/3;


        spacing: 1





        RoundButton {
         Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: screen.width*0.5;
              Layout.preferredHeight: screen.height*0.07
            buttonColor: "#08F20F";

            onClicked: screen.catalogClick();


            labelText: qsTr("Category Catalog");

        }

        RoundButton {
          Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: screen.width*0.5;
            Layout.preferredHeight: screen.height*0.07
            buttonColor: "#EAF208"

             labelText: qsTr("Privacy policy");

             onClicked: {Qt.openUrlExternally("https://play.google.com/store/apps/details?id=com.tocaboca.tocalifeworld&hl=en&gl=US") }


        }

        RoundButton {
          Layout.alignment: Qt.AlignCenter
             Layout.preferredWidth: screen.width*0.5;
               Layout.preferredHeight: screen.height*0.07
            buttonColor: "#EAF208"

             labelText: qsTr("About");

             onClicked: {Qt.openUrlExternally("https://play.google.com/store/apps/details?id=com.tocaboca.tocalifeworld&hl=en&gl=US") }

}


    }

}
