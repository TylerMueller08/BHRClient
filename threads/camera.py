from PySide6.QtCore import QObject, Property, Signal, Slot
from PySide6.QtMultimedia import QMediaDevices
 
 
class CameraFinder(QObject):
    camerasChanged = Signal()
 
    def __init__(self, parent=None):
        super().__init__(parent)
        self._revision = 0
        # Watch for cameras being plugged in or unplugged
        self._media_devices = QMediaDevices(self)
        self._media_devices.videoInputsChanged.connect(self._on_inputs_changed)
 
    def _on_inputs_changed(self):
        self._revision += 1
        self.camerasChanged.emit()
 
    # QML bindings that read this property re-evaluate whenever it changes,
    # which is how the panels notice hot-plugged cameras.
    @Property(int, notify=camerasChanged)
    def revision(self):
        return self._revision
 
    @Slot(str, result=int)
    def indexOf(self, key):
        key = key.lower()
        for index, cam in enumerate(QMediaDevices.videoInputs()):
            cam_id = cam.id().data().decode("utf-8", errors="replace").lower()
            if key in cam_id:
                return index
        return -1