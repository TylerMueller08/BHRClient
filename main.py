import sys, time, serial

from PySide6.QtCore import QObject, Slot
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

from threads.camera import CameraFinder

def main():
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    camera_finder = CameraFinder()
    engine.rootContext().setContextProperty("cameraFinder", camera_finder)

    engine.load("main.qml")
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())

if __name__ == "__main__":
    main()


# TODO: Move to seperate file.
class Controller(QObject):
    def __init__(self):
        super().__init__()
        self.ser = serial.Serial('COM3', 9600)
        time.sleep(2)

    @Slot()
    def launch(self):
        self.ser.write(b'A')
        time.sleep(1)

    def close(self):
        self.ser.close()