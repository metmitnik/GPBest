import QtQuick 2.15

Item {
    id:button;
    property alias fontSize: label.font.pixelSize;
    property alias labelText: label.text;
    property alias buttonColor: rect.color;

    property bool enabled :true;

    signal clicked();


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

        border.color: "#a0adbb"//"#6bbdbb"

        MouseArea {
            onPressed: { if(button.enabled) {button.opacity = 0.7; timer.start();}}
            onReleased:  { if(button.enabled) {button.opacity = 1; button.clicked(); console.log(rect.color)}}
            onExited: { if(button.enabled) {button.opacity = 1;}}
           // onDragChanged: {button.opacity = 1;}


            anchors.fill: parent


        }


    }

    TextMetrics {
        id:textMetricks
        font.family: appWindow.appFontName;
        font.pixelSize: label.font.pixelSize;
        elide: "ElideRight";
        elideWidth: label.width;
        font.bold: true;
//        onTextChanged: {
//        console.log("mmmm1", text, elidedText, elidedText.indexOf("..."))
//       ///     label.text = elidedText;
//            while(elidedText != "" && elidedText != label.text){
//                 console.log("sss", textMetricks.elidedText, font.pixelSize)
//                textMetricks.font.pixelSize --;
//                 textMetricks.text = text;
//                if(textMetricks.elidedText != ""){
//                    label.font.pixelSize = textMetricks.font.pixelSize;
//                    label.text =  textMetricks.elidedText;
//                }
//            }

//        }
    }




    Text {
        id:label
        font.family: appWindow.appFontName;

        font.bold: true;
        font.pixelSize: parent.height*0.28
        color: "#1c2421";
        textFormat: Text.RichText;
        lineHeight: 0.8


        //text : textMetricks.elidedText;
       //text: "My folders"

        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;

        anchors.fill: parent;
        anchors.margins: 2;
        clip: true;
        wrapMode: Text.WordWrap;

        onTextChanged: {
           textMetricks.elideWidth = width*1.6;
            textMetricks.font.pixelSize =  font.pixelSize;
            textMetricks.font.family = font.family;
             textMetricks.font.bold = font.bold;

  textMetricks.text = text;
            if(textMetricks.elidedText != ""){
                label.text = textMetricks.elidedText;
            }
              console.log("sss1",textMetricks.elidedText,textMetricks.elidedText.indexOf("..."), lineCount)
//              while(textMetricks.elidedText != "" && textMetricks.elidedText.indexOf("...") != -1){
//                   console.log("sss", textMetricks.elidedText, font.pixelSize)
//                  textMetricks.font.pixelSize --;
//                   textMetricks.text = text;
//                  if(textMetricks.elidedText != ""){
//                      font.pixelSize = textMetricks.font.pixelSize;
//                      label.text =  textMetricks.elidedText;
//                  }
//              }




//            console.log("sss",text, label.text, textMetricks.elidedText, font.pixelSize)




        }

    }



}
