import QtQuick
import QtQuick.Window
import QtQuick.Shapes
Shape {
    id:root
    width: 600
    height: 150
    property int weight: 50
    property int type: -1 // 1 is upper, 0 is straight, -1 is lower
    property real curve: 0.5 // 0 - 1
    property real _Hcurve: 100 // 0 - 1
    property alias color: path.fillColor
    property alias borderColor: path.strokeColor

    anchors.centerIn: parent
    antialiasing: true
    ShapePath {
        id:path
        strokeWidth: 1
        strokeColor: "black"
        fillColor: "red"
        startX: 0; startY: (root.height * 0.5) - (root.weight * 0.5)

        PathCurve {
            id: _2node
            x: root.width * root.curve ;
            y: {
                if(root.type == 0 )
                    return path.startY
                else if (root.type > 0)
                    return path.startY + (root.weight * 0.25)
                else
                    return path.startY - (root.weight * 0.25)
            }
        }

        PathCurve {
            id: _3node
            x: root.width;
            y: {
                if(root.type == 0 )
                    return path.startY
                else if (root.type > 0)
                    return path.startY - (root.weight * 0.25) - root._Hcurve
                else
                    return path.startY + (root.weight * 0.25) + root._Hcurve
            }
        }

        /*
             * ----
             */

        PathLine { x: _3node.x; y: _3node.y + root.weight }
        /*
            * |
            * |
            */

        PathCurve { x: _2node.x; y: _2node.y + root.weight }
        PathCurve { x: path.startX; y: path.startY + root.weight }
        PathLine { x: path.startX; y:path.startY }

        /*
             * ----
             */

    }
}
