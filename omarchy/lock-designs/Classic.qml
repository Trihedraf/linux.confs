// Customized copy of the Classic design. Edit it here or with:
//   omarchy-shell lock editDesign my-classic
import QtQuick
import qs.Commons
import "../plugins/io.github.sirjul1337.lock-explorer/designs"

DesignBase {
  id: lock
  inputItem: field.input

  Wallpaper { anchors.fill: parent; lock: lock; blur: 0.0; dim: 0.0; contrast: 0.0; vignette: false }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onClicked: { lock.wakeRequested(); lock.forcePasswordFocus() }
    onPositionChanged: lock.wakeRequested()
  }

  PasswordField {
    id: field
    lock: lock
    anchors.centerIn: parent
    width: 360
    height: 45
    radius: Style.cornerRadius
    outlineThickness: 1
    showLockGlyph: false
    shakeOnFail: false
    placeholder: lock.tr("Enter Password")
    fontScale: 1.125
  }
}
