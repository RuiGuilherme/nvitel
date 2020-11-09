import QtQuick 2.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: configGeneral
    Layout.fillWidth: true

    property alias cfg_delay: delay.value

    GridLayout {
        columns: 2

        PlasmaComponents.Label {
            text: i18n("Update interval:")
        }

        SpinBox {
            id: delay
            suffix: i18n(" sec")
            minimumValue: 1
            maximumValue: 128
        }
    }
}
