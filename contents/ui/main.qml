import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import QtGraphicalEffects 1.0
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

Item {
    id: root

    property string icon: Qt.resolvedUrl("nvidia-off.svg")
    property bool stat: false

    Component.onCompleted: {
        checkTimer.start()
    }

    function switchCard(){
        executable.exec("~/.local/share/plasma/plasmoids/org.kde.plasma.nvitel/contents/ui/./switch.sh") 
    }

    function getCurrentProcess() {
        executable.exec("~/.local/share/plasma/plasmoids/org.kde.plasma.nvitel/contents/ui/./process.sh")
    }

    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: {
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            exited(sourceName, exitCode, exitStatus, stdout, stderr)
            disconnectSource(sourceName)
        }
        function exec(cmd) {
            if (cmd) {
                connectSource(cmd)
            }
        }
        signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
    }

    function check() {
        executable.exec("nvidia-settings -q=GPUUtilization -t")
    }

    Connections {
        target: executable
        onExited: {
            var formattedText = stdout.trim()
            var formattedText2 = parseInt(formattedText.replace(/\D+/g, ""))
            var errorText = stderr
            if (formattedText2 > 0) {
                root.icon = Qt.resolvedUrl("nvidia-on.svg")
                root.stat = true
            } else {
                root.icon = Qt.resolvedUrl("nvidia-off.svg")
                root.stat = false
            }
        }
    }

    Connections {
        target: plasmoid.configuration
    }

    Item {
        id: tool

        property int preferredTextWidth: units.gridUnit * 20
        Layout.minimumWidth: childrenRect.width + units.gridUnit
        Layout.minimumHeight: childrenRect.height + units.gridUnit
        Layout.maximumWidth: childrenRect.width + units.gridUnit
        Layout.maximumHeight: childrenRect.height + units.gridUnit

        RowLayout {

            anchors {
                left: parent.left
                top: parent.top
                margins: units.gridUnit / 2
            }

            spacing: units.largeSpacing
            Image {
                id: tooltipImage
                source: root.icon
                Layout.alignment: Qt.AlignTop
                Layout.preferredWidth: 48
                Layout.preferredHeight: 48
                ColorOverlay {
                    anchors.fill: tooltipImage
                    source: tooltipImage
                    color: PlasmaCore.ColorScope.textColor
                    visible: root.stat ? false : true
                    antialiasing: true
                }
            }

            ColumnLayout {
                PlasmaExtras.Heading {
                    id: tooltipMaintext
                    level: 3
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    wrapMode: Text.Wrap
                    text: "Prime Render Offload Status"
                    visible: text != ""
                }
                PlasmaComponents.Label {
                    id: tooltipSubtext
                    Layout.fillWidth: true
                    height: undefined
                    wrapMode: Text.WordWrap
                    text: root.stat ? "Nvidia GPU is currently in use" : "Nvidia GPU is currently not used"
                    opacity: root.stat ? 1 : 0.8
                    visible: text != ""
                    maximumLineCount: 8
                }
                PlasmaComponents.ToolButton {
                    iconSource: "view-refresh-symbolic"
                    text: i18n("Switch video card")
                    onClicked: switchCard()
                }
                PlasmaComponents.ToolButton {
                    text: i18n("Get processes are using nvidia-GPU")
                    onClicked: getCurrentProcess()
                }
            }
        }
    }

    Plasmoid.compactRepresentation: Item {
        PlasmaCore.IconItem {
            id: ima
            anchors.fill: parent
            //            anchors.topMargin: 3
            //            anchors.bottomMargin: 3
            source: root.icon
            opacity: root.stat ? 1 : 0.7            
            ColorOverlay {
                anchors.fill: ima
                source: ima
                visible: root.stat ? false : true
                color: PlasmaCore.ColorScope.textColor
                antialiasing: true
                opacity: root.stat ? 1 : 0.7
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }
        PlasmaCore.ToolTipArea {
            id: toolTip
            width: parent.width
            height: parent.height
            anchors.fill: parent
            mainItem: tool
            interactive: true
        }
    }

    Plasmoid.fullRepresentation: Item {}

    Timer {
        id: checkTimer
        interval: plasmoid.configuration.delay * 1000
        running: false
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            check()
        }
    }
}
