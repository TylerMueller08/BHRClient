from PySide6.QtCore import QObject

class ServiceHandler(QObject):

    def __init__(self):
        super().__init__()

    def connect_cameras(self):
        pass