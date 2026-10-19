from PySide6.QtCore import QObject, Property, Signal

# Example Telemetry Class
class Telemetry(QObject):
    temperatureChanged = Signal()
    pressureChanged = Signal()
    speedChanged = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)

        self._temperature = 0.0
        self._pressure = 0.0
        self._speed = 0.0

    @Property(float, notify=temperatureChanged)
    def temperature(self):
        return self._temperature

    @Property(float, notify=pressureChanged)
    def pressure(self):
        return self._pressure

    @Property(float, notify=speedChanged)
    def speed(self):
        return self._speed

    def update_temperature(self, value):
        if value != self._temperature:
            self._temperature = value
            self.temperatureChanged.emit()

    def update_pressure(self, value):
        if value != self._pressure:
            self._pressure = value
            self.pressureChanged.emit()

    def update_speed(self, value):
        if value != self._speed:
            self._speed = value
            self.speedChanged.emit()
