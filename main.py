import sys, os

from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

def main():
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"
    os.environ["QT_QUICK_CONTROLS_MATERIAL_THEME"] = "Dark"

    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load("main.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())

if __name__ == "__main__":
    main()