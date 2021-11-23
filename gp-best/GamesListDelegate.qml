import QtQuick 2.0
 import QtGraphicalEffects 1.15

Item {
    id:delegate;
    property string installsLb: "Installs";
    signal gameClicked(string gameJson);
    FontLoader { id: loclaFont; source: "qrc:/assets/comic.ttf" }

    MouseArea {
        onReleased: { delegate.sendGameClicked();}



        anchors.fill: im


    }

    Image {
        id:im;
        anchors.top: parent.top;
        anchors.left: parent.left;
        width: 100;
        height: 100;
        sourceSize: Qt.size(100,100);
        source: image;



//        property bool rounded: true
//            property bool adapt: true

//            layer.enabled: rounded
//            layer.effect: ShaderEffect {
//                property real adjustX: image.adapt ? Math.max(width / height, 1) : 1
//                property real adjustY: image.adapt ? Math.max(1 / (width / height), 1) : 1

//                fragmentShader: "
//                #ifdef GL_ES
//                    precision lowp float;
//                #endif // GL_ES
//                varying highp vec2 qt_TexCoord0;
//                uniform highp float qt_Opacity;
//                uniform lowp sampler2D source;
//                uniform lowp float adjustX;
//                uniform lowp float adjustY;

//                void main(void) {
//                    lowp float x, y;
//                    x = (qt_TexCoord0.x - 0.5) * adjustX;
//                    y = (qt_TexCoord0.y - 0.5) * adjustY;
//                    float delta = adjustX != 1.0 ? fwidth(y) / 2.0 : fwidth(x) / 2.0;
//                    gl_FragColor = texture2D(source, qt_TexCoord0).rgba
//                        * step(x * x + y * y, 0.25)
//                        * smoothstep((x * x + y * y) , 0.25 + delta, 0.25)
//                        * qt_Opacity;
//                }"
//            }
        visible: false

    }

    OpacityMask {
        anchors.fill: im
        source: im
        maskSource: Rectangle {
            width: im.width
            height: im.height
            radius: 5
            visible: false // this also needs to be invisible or it will cover up the image
        }
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


            delegate.sendGameClicked();

        }
    }

    function sendGameClicked(){
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

    Text {
          font.family: appWindow.appFontName;
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
          font.family: appWindow.appFontName;
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
          font.family: appWindow.appFontName;
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
