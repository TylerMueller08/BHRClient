import sys

from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

from EmbeddedWindow import EmbeddedWindow

def main():
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    synnaxApp = EmbeddedWindow.create()
    engine.rootContext().setContextProperty("synnaxApp", synnaxApp)

    engine.load("main.qml")
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())

if __name__ == "__main__":
    main()