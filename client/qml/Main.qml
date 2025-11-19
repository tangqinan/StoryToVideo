import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    width: 1280
    height: 720
    visible: true
    title: "StoryToVideo"
    color: "#1E1E1E"

    property color accent: "#3B82F6"

    // Mock data to illustrate layout; replace with real API wiring.
    property var mockProjects: [
        { title: "Sample Story", created: "2025-11-17", cover: "", status: "Draft" },
        { title: "Space Tale", created: "2025-11-15", cover: "", status: "Generated" }
    ]

    header: ToolBar {
        contentHeight: 40
        Label {
            text: "StoryToVideo"
            font.bold: true
            color: "white"
            verticalAlignment: Label.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            padding: 12
        }
    }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: assetsPage
    }

    Component {
        id: assetsPage
        Page {
            padding: 16
            background: Rectangle { color: "transparent" }

            ColumnLayout {
                anchors.fill: parent
                spacing: 12
                RowLayout {
                    Layout.fillWidth: true
                    Label { text: "Assets"; color: "white"; font.pixelSize: 22; Layout.fillWidth: true }
                    Button {
                        text: "+ New"
                        background: Rectangle { color: accent; radius: 4 }
                        onClicked: stack.push(createPage)
                    }
                }
                GridView {
                    id: grid
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cellWidth: 260
                    cellHeight: 160
                    model: mockProjects
                    delegate: Frame {
                        width: grid.cellWidth - 12
                        height: grid.cellHeight - 12
                        background: Rectangle { color: "#2A2A2A"; radius: 8; border.color: "#2f2f2f" }
                        Column {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 6
                            Rectangle { width: parent.width; height: 70; color: "#3a3a3a"; radius: 6 }
                            Label { text: modelData.title; color: "white"; elide: Label.ElideRight }
                            Label { text: modelData.created; color: "#9CA3AF"; font.pixelSize: 12 }
                            Button {
                                text: "Open"
                                onClicked: stack.push(storyboardPage)
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: createPage
        Page {
            padding: 16
            background: Rectangle { color: "transparent" }

            ColumnLayout {
                anchors.fill: parent
                spacing: 12
                RowLayout {
                    Layout.fillWidth: true
                    Label { text: "Create Story"; color: "white"; font.pixelSize: 22; Layout.fillWidth: true }
                    Button { text: "Back"; onClicked: stack.pop() }
                }
                SplitView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    orientation: Qt.Horizontal
                    TextArea {
                        placeholderText: "Enter story text (<=500 words)"
                        Layout.minimumWidth: 400
                        wrapMode: TextArea.Wrap
                        color: "white"
                        background: Rectangle { color: "#2A2A2A"; radius: 8 }
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        Label { text: "Style"; color: "white" }
                        ComboBox { model: ["Cinematic", "Anime", "Realistic"]; currentIndex: 0 }
                        Button {
                            text: "Generate Storyboard"
                            Layout.alignment: Qt.AlignLeft
                            background: Rectangle { color: accent; radius: 6 }
                            onClicked: {
                                // TODO: call API, handle loading
                                stack.push(storyboardPage)
                            }
                        }
                        Label { text: "Shows loading/WS progress here."; color: "#9CA3AF"; wrapMode: Label.Wrap }
                    }
                }
            }
        }
    }

    Component {
        id: storyboardPage
        Page {
            padding: 16
            background: Rectangle { color: "transparent" }

            ColumnLayout {
                anchors.fill: parent
                spacing: 12
                RowLayout {
                    Layout.fillWidth: true
                    Label { text: "Storyboard"; color: "white"; font.pixelSize: 22; Layout.fillWidth: true }
                    Button { text: "Back"; onClicked: stack.pop() }
                    Button { text: "Generate All" }
                    Button { text: "Preview"; onClicked: stack.push(previewPage) }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#2A2A2A"
                    radius: 8
                    border.color: "#333"
                    Text { anchors.centerIn: parent; text: "Main preview area"; color: "#9CA3AF" }
                }
                ListView {
                    id: timeline
                    Layout.fillWidth: true
                    Layout.preferredHeight: 150
                    orientation: ListView.Horizontal
                    spacing: 8
                    model: 6
                    delegate: Frame {
                        width: 160; height: 140
                        background: Rectangle { color: "#252525"; radius: 6; border.color: index === timeline.currentIndex ? accent : "#303030" }
                        Column {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 4
                            Rectangle { width: parent.width; height: 70; color: "#3a3a3a"; radius: 4 }
                            Label { text: "Shot " + (index+1); color: "white" }
                            Label { text: "Status: Pending"; color: "#9CA3AF"; font.pixelSize: 12 }
                            Button {
                                text: "Detail"
                                onClicked: stack.push(shotDetailPage)
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: shotDetailPage
        Page {
            padding: 16
            background: Rectangle { color: "transparent" }

            ColumnLayout {
                anchors.fill: parent
                spacing: 12
                RowLayout {
                    Layout.fillWidth: true
                    Label { text: "Shot Detail"; color: "white"; font.pixelSize: 22; Layout.fillWidth: true }
                    Button { text: "Back"; onClicked: stack.pop() }
                }
                SplitView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#2A2A2A"
                        radius: 8
                        border.color: "#333"
                        Text { anchors.centerIn: parent; text: "Image placeholder"; color: "#9CA3AF" }
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 8
                        Label { text: "Prompt"; color: "white" }
                        TextArea { Layout.fillWidth: true; Layout.preferredHeight: 120; wrapMode: TextArea.Wrap; color: "white"; background: Rectangle { color: "#2A2A2A"; radius: 6 } }
                        Label { text: "Narration"; color: "white" }
                        TextArea { Layout.fillWidth: true; Layout.preferredHeight: 80; wrapMode: TextArea.Wrap; color: "white"; background: Rectangle { color: "#2A2A2A"; radius: 6 } }
                        ComboBox { model: ["Crossfade", "Ken Burns", "Volume Mix"]; currentIndex: 0 }
                        RowLayout {
                            spacing: 8
                            Button { text: "Generate Image"; background: Rectangle { color: accent; radius: 6 } }
                            Button { text: "Regenerate" }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: previewPage
        Page {
            padding: 16
            background: Rectangle { color: "transparent" }
            ColumnLayout {
                anchors.fill: parent
                spacing: 12
                RowLayout {
                    Layout.fillWidth: true
                    Label { text: "Preview"; color: "white"; font.pixelSize: 22; Layout.fillWidth: true }
                    Button { text: "Back"; onClicked: stack.pop() }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 400
                    color: "#2A2A2A"
                    radius: 8
                    border.color: "#333"
                    Text { anchors.centerIn: parent; text: "Player placeholder"; color: "#9CA3AF" }
                }
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    Button { text: "Play" }
                    Button { text: "Pause" }
                    Slider { Layout.fillWidth: true; from: 0; to: 100 }
                    Button { text: "Export" }
                }
            }
        }
    }
}
