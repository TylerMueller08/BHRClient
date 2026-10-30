import sys

from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType

from threads.CameraHandler import CameraHandler
from threads.TelemetryController import TelemetryController
from widgets.PyQtGraph import PyQtGraphItem

def main():
    app = QApplication(sys.argv)
    qmlRegisterType(PyQtGraphItem, "TelemetryGraph", 1, 0, "PyQtGraphItem")
    engine = QQmlApplicationEngine()

    camera_finder = CameraHandler()
    engine.rootContext().setContextProperty("cameraFinder", camera_finder)

    telemetry_controller = TelemetryController()
    engine.rootContext().setContextProperty("telemetry", telemetry_controller)

    engine.load("main.qml")
    if not engine.rootObjects():
        sys.exit(-1)

    telemetry_controller.cleanup()
    sys.exit(app.exec())

if __name__ == "__main__":
    main()