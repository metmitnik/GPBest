import QtQuick 2.0

Item {
    id:delegate;
    property string installsLb: "Installs";
    signal gameClicked(string gameJson);
    FontLoader { id: loclaFont; source: "qrc:/assets/comic.ttf" }

    Image {
        id:im;
        anchors.top: parent.top;
        anchors.left: parent.left;
        width: 100;
        height: 100;
        sourceSize: Qt.size(100,100);
        source: image;

    }

    RoundButton {
        id:btn;
        anchors.left: im.right;
        anchors.right: parent.right;
        anchors.top: parent.top;
        anchors.margins: 10;
        anchors.topMargin: 10;
        fontSize: 14;
        height: 40;
        buttonColor: "#72cdcb"
        labelText: name
        onClicked: {



            let o = {};
            o.image = image;
            o.name = name;
            o.installs = installsLb.text;
            o.stars = stars;
            o.size = size;
            o.gameUrl = gameUrl;
            o.desc = desc
            console.log(screenshots, screenshots.count);
            let i = 0;
            let scrs = [];
            while(i < screenshots.count){
                scrs.push({"src": screenshots.get(i).src})
                i++;
            }
            o.screenshots = scrs;
            delegate.gameClicked(JSON.stringify(o));
        }
    }

    Text {
          font.family: loclaFont.name;
        id:rate;
        anchors.bottom: parent.bottom;
        anchors.left: im.right;
        anchors.margins: 10;
        anchors.bottomMargin: 20
        font.pixelSize: 18;
        color: "#ffffff"
        text: stars;
    }
    Image {

        id:stim;
        anchors.top: rate.top;
        anchors.left: rate.right;
        width: 20;
        height: 20;
        sourceSize: Qt.size(20,20);
        source: "qrc:/assets/icons/Favorite-white.svg";

    }
    Text {
          font.family: loclaFont.name;
        id:sizeLb;
        anchors.top: rate.top;
        anchors.left: rate.right;
           anchors.right: installsLb.left;
        horizontalAlignment: Text.AlignHCenter;
        wrapMode: Text.WordWrap;

        font.pixelSize: 18;
        color: "#ffffff"
        text: size;
    }

    Text {
          font.family: loclaFont.name;
        id:installsLb;
        anchors.top: rate.top;
        anchors.right: parent.right;
        horizontalAlignment: Text.AlignRight;
        anchors.rightMargin: 10;

        font.pixelSize: 14;
        color: "#ffffff"
        text: instals + delegate.installsLb;
    }



}
