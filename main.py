import sys, os

from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide6.QtGui import QIcon

from threads.CameraHandler import CameraHandler
from threads.TelemetryController import TelemetryController
from widgets.PyQtGraph import PyQtGraphItem

def main():
    if os.name == 'nt':
        import ctypes
        ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID('bluehorizon.rocketry.app')

    app = QApplication(sys.argv)
    qmlRegisterType(PyQtGraphItem, "TelemetryGraph", 1, 0, "PyQtGraphItem")
    engine = QQmlApplicationEngine()

    camera_finder = CameraHandler()
    telemetry_controller = TelemetryController()
    engine.rootContext().setContextProperty("cameraFinder", camera_finder)
    engine.rootContext().setContextProperty("telemetry", telemetry_controller)

    engine.load("main.qml")
    if not engine.rootObjects():
        sys.exit(-1)

    window = engine.rootObjects()[0]
    window.setIcon(QIcon("resources/BlueHorizon.ico"))

    app.aboutToQuit.connect(telemetry_controller.cleanup)
    sys.exit(app.exec())

if __name__ == "__main__":
    main()