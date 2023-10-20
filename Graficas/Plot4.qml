import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCharts

Page {
    ChartView {
        title: "Gráfica 4"
        anchors.fill: parent
        antialiasing: true
        legend.alignment: Qt.AlignBottom

        BarSeries {
            id: plot
            axisX: BarCategoryAxis {
                categories: ["2023"]
            }
            axisY: ValuesAxis {
                min: 0
                max: 150
            }
        }
    }

    function populate() {
        plot.append("Carlos", [20]);
        plot.append("Ana", [50]);
        plot.append("Luis", [110]);
    }

    Component.onCompleted: {
        this.populate();
    }
}
