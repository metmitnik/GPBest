import QtQuick 2.15
//import QtQuick.Controls 2.5
 import QtGraphicalEffects 1.15

Item {
    id:root;

    FontLoader { id: loclaFont; source: "qrc:/assets/comic.ttf" }


    property alias installLb: btnInstall.labelText;
    property alias catalogLb: btnCatalog.labelText;
    property alias backLb: btnBack.labelText;

    property string url : "";

    signal goBack();
    signal goCatalog();


    ListView {
        id:screenshotsModel;
    }

    function initData(data){
        image.source = data.image
        title.labelText =   data.name;
        installsLb.text = data.installs;
        rate.text = data.stars;
        sizeLb.text = data.size
        list.model = data.screenshots;
        root.url = data.gameUrl;




           flick.descText = data.desc;

        //        screenshotsModel.clear();


        //        for(var i in o.screenshots){
        //          screenshotsModel.append({"src":o.screenshots[i]})

        //        }

    }



    Image {
        id: image
        anchors.left: parent.left;
        anchors.top: parent.top;
        anchors.margins: 10;
        anchors.topMargin: 35;
        width: 150
        height: 150;
        sourceSize.height: 150
        sourceSize.width: 150
         visible: false

    }

    OpacityMask {
        anchors.fill: image
        source: image
        maskSource: Rectangle {
            width: image.width
            height: image.height
            radius: 5
            visible: false // this also needs to be invisible or it will cover up the image
        }
    }


    RoundButton {
        id: title;
        anchors.left: image.right;
        anchors.right: parent.right;
        anchors.top: image.top;
        anchors.leftMargin: 10;
        anchors.rightMargin: 10;
        height: 100;
        enabled: false;

    }

    Text {
          font.family: appWindow.appFontName;
        id: installsLb
        anchors.left: image.right;
        anchors.right: parent.right;
        anchors.bottom: image.bottom;
        anchors.margins: 5;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;
        wrapMode: Text.WordWrap;
        font.pixelSize: 18;
        color: "#ffffff";
        height: 50;
    }


    Text {
        font.family: appWindow.appFontName;
        id:rate;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.margins: 10;
        anchors.topMargin: 200;
        font.pixelSize: 35;
        color: "#ffffff"

    }
    Image {
        id:stim;
        anchors.top: rate.top;
        anchors.left: rate.right;
        width: 40;
        height: 40;
        sourceSize: Qt.size(40,40);
        source: "qrc:/assets/icons/Favorite-white.svg";

    }
    Text {
        font.family: appWindow.appFontName;
        id:sizeLb;
        anchors.top: rate.top;
        anchors.rightMargin: 10;
        anchors.right: parent.right;
        anchors.left: stim.right;
        horizontalAlignment: Text.AlignRight;
        wrapMode: Text.WordWrap;

        font.pixelSize: 35;
        color: "#ffffff";
    }

    ListView {
        id:list;
        anchors.top:  sizeLb.bottom;
        width: 120*3+20;
        height: 100;
        anchors.horizontalCenter: parent.horizontalCenter;


        anchors.topMargin: 10;
        orientation: ListView.Horizontal;
        model: screenshotsModel;
        spacing: 5;
        delegate: Image {
            width: 120
            height: 120;
            sourceSize.height: 120
            sourceSize.width: 120
            source: modelData.src;
            fillMode: Image.PreserveAspectFit
            transformOrigin: Item.Center
        }

    }

    RoundButton {
        id: btnInstall;
        anchors.top: list.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.topMargin: 30;
        width: parent.width*0.7;
        buttonColor: "#72cdcb";
        height: 60;
        onClicked: {

            Qt.openUrlExternally(root.url);

        }


    }
    RoundButton {
        id:btnBack;
        anchors.topMargin: 10

        anchors.left: btnInstall.left;
        anchors.top: btnInstall.bottom;
        width: btnInstall.width/2 - 5;

        height: 60;


        buttonColor: "#72cdcb"

        onClicked: {root.goBack()}

    }
    RoundButton {
        id:btnCatalog

        anchors.topMargin: 10

        anchors.right: btnInstall.right;
        anchors.top: btnInstall.bottom;

        width: btnBack.width
        height: 60;


        buttonColor: "#72cdcb"

        onClicked: {root.goCatalog()}

    }

    Flickable {
        id: flick

        anchors.margins: 10;
        anchors.top: btnCatalog.bottom
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;

        contentWidth: textD.paintedWidth
        contentHeight: textD.paintedHeight
        clip: true

        property  alias  descText: textD.text;




        function ensureVisible(r)
        {
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX+width <= r.x+r.width)
                contentX = r.x+r.width-width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY+height <= r.y+r.height)
                contentY = r.y+r.height-height;
        }
        TextEdit {
            id:textD
            width: flick.width-11;
            height: flick.height;
            font.family: appWindow.appFontName;
          //  textFormat: TextEdit.RichText;



             text: "<b>Hello</b> <i>World!</i>"
           // font.family: codeFont.name;
            font.pointSize: 18
            color: "#FFFFFF"

            textFormat: TextEdit.AutoText;
            readOnly: true
            wrapMode: Text.WordWrap
            horizontalAlignment: TextEdit.AlignHCenter
           // selectByMouse: true

           // focus: true
        }
    }





}
