from PySide6.QtCore import QObject, QTimer, Signal, Slot
import random, json

class SimulatedLink(QObject):
    frameReceived = Signal(dict) # Input channel values.
    stateChanged = Signal(bool, str)

    def __init__(self, interval_ms=1000):
        super().__init__()
        self._timer = QTimer(self)
        self._timer.setInterval(interval_ms)
        self._timer.timeout.connect(self._tick)

    def open(self):
        self._timer.start()
        self.stateChanged.emit(True, "Simulator Connected")

    def close(self):
        self._timer.stop()
        self.stateChanged.emit(False, "Simulator Disconnected")

    def send(self, data: bytes) -> bool:
        print(f"[Simulator] Sending data: {data}")
        return True

    def _tick(self):
        self.frameReceived.emit({
            "oxygen": round(random.uniform(75.0, 95.0), 1),
            "fuel": round(random.uniform(60.0, 90.0), 1),
            "nitrogen": round(random.uniform(40.0, 60.0), 1)
        })


class RocketChannelWorker(QObject):
    telemetryReceived = Signal(dict) # Input channel values.
    connectionStateChanged = Signal(bool, str) # Status of rocket connection.
    commandSent = Signal(str, bool) # Command sent to the rocket.

    def __init__(self, link_factory=SimulatedLink):
        super().__init__()
        self._link_factory = link_factory
        self._link = None

    @Slot()
    def start(self):
        self._link = self._link_factory()
        self._link.setParent(self)
        self._link.frameReceived.connect(self.telemetryReceived)
        self._link.stateChanged.connect(self.connectionStateChanged)
        self._link.open()

    @Slot()
    def stop(self):
        if self._link:
            self._link.close()

    @Slot(str, str)
    def dispatch(self, command_name, payload):
        data = json.dumps({"cmd": command_name, "payload": payload}).encode() + b"\n"
        ok = self._link is not None and self._link.send(data)
        self.commandSent.emit(command_name, ok)