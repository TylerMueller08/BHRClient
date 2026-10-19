import sys

from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

from threads.telemetry import Telemetry

def main():
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    telemetry = Telemetry()
    engine.rootContext().setContextProperty("telemetry", telemetry)

    engine.load("main.qml")
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())

if __name__ == "__main__":
    main()