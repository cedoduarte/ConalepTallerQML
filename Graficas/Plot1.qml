import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCharts

Page {
    ChartView {
        title: "Gráfica 1"
        anchors.fill: parent
        antialiasing: true
        legend.alignment: Qt.AlignBottom

        LineSeries {
            id: plot
            name: "línea A"
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

        LineSeries {
            id: plot2
            name: "línea B"
            color: "blue"
        }
    }

    function populate() {
        let x = 0;
        let y = 10;
        while (x <= 10) {
            plot.append(x, y);
            x++;
            y--;
        }

        x = 0;
        y = 0;
        while (x <= 10) {
            plot2.append(x, y);
            x++;
            y++;
        }
    }

    Component.onCompleted: {
        this.populate();
    }
}
