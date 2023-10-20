import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCharts

Page {
    ChartView {
        title: "Gráfica 3"
        anchors.fill: parent
        antialiasing: true
        legend.alignment: Qt.AlignBottom

        LineSeries {
            id: plot
            name: "curva"
            color: "red"
            axisX: ValuesAxis {
                min: -10
                max: 10
            }
            axisY: ValuesAxis {
                min: -10
                max: 10
            }
        }
    }

    function populate() {
        for (let x = -10; x <= 10; x += 0.1) {
            let y = x*x;
            plot.append(x, y);
        }
    }

    Component.onCompleted: {
        this.populate();
    }
}
