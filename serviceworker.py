from PySide6.QtCore import QThread

class ServiceWorker(QThread):
    def __init__(self):
        super().__init__()

    