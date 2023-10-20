import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCharts

Page {
    ChartView {
        title: "Gráfica 2"
        anchors.fill: parent
        antialiasing: true
        legend.alignment: Qt.AlignBottom

        PieSeries {
            id: plot
        }
    }

    function populate() {
        let sliceA = plot.append("A", 30);
        sliceA.color = "#3dd465";

        let sliceB = plot.append("B", 30);
        sliceB.color = "red";
        sliceB.exploded = true;

        let sliceC = plot.append("C", 30);
        sliceC.color = "yellow";
        sliceC.borderColor = "black";
        sliceC.exploded = true;

        let sliceD = plot.append("D", 10);
        sliceD.color = "orange";
    }

    Component.onCompleted: {
        this.populate();
    }
}
