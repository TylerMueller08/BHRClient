from PySide6.QtCore import QThread, QObject, Signal, Slot, QMetaObject, Property, Qt, Q_ARG
from PySide6.QtGui import QVector3D
from collections import deque
import time

from threads.ChannelWorker import RocketChannelWorker, SimulatedLink

class TelemetryController(QObject):
    dataChanged = Signal()
    commandRequested = Signal(str, str)

    COLORS = {"oxygen": "#004F98", "fuel": "#00984F", "nitrogen": "#D97706"}

    def __init__(self, link_factory=SimulatedLink):
        super().__init__()

        # Channel properties for QML.
        self.channels = {
            "oxygen": 0.0,
            "fuel": 0.0,
            "nitrogen": 0.0,
            "altitude": 0.0,
            "attitude": QVector3D(0,0,0)
        }

        self._active_gauge = "oxygen"
        self._graph_item = None

        # Graph History.
        self.max_len = 60
        self._t0 = time.monotonic()
        self.time_history = deque(maxlen=self.max_len)
        self.history = {name: deque(maxlen=self.max_len) for name in self.channels}

        # Thread & Worker.
        self._thread = QThread(self)
        self._worker = RocketChannelWorker(link_factory)
        self._worker.moveToThread(self._thread)

        self._thread.started.connect(self._worker.start)
        self._thread.finished.connect(self._worker.deleteLater)

        self._worker.telemetryReceived.connect(self.handleTelemetry)
        self._worker.connectionStateChanged.connect(self.handleConnectionStateChanged)
        self._worker.commandSent.connect(self.handleCommandSent)

        self.commandRequested.connect(self._worker.dispatch)
        self._thread.start()

    @Slot(bool, str)
    def handleConnectionStateChanged(self, connected, message):
        print(f"Connection Status: {connected} - {message}")

    @Slot(str, bool)
    def handleCommandSent(self, command_name, success):
        if not success:
            print(f"Command '{command_name}' failed.")

    @Slot(dict)
    def handleTelemetry(self, values):
        self.time_history.append(round(time.monotonic() - self._t0, 2))

        for name, value in values.items():
            if name in self.channels:
                self.channels[name] = value
                self.history[name].append(value)

        self.dataChanged.emit()
        self.refreshGraph()

    def refreshGraph(self):
        if self._graph_item and self._active_gauge in self.history:
            self._graph_item.update_plot(
                list(self.time_history),
                list(self.history[self._active_gauge]),
                self._active_gauge.capitalize(),
                self.COLORS[self._active_gauge]
            )

    @Slot(str)
    def selectGauge(self, name):
        name = name.lower()
        if name in self.history:
            self._active_gauge = name
            self.dataChanged.emit()
            self.refreshGraph()

    @Slot(QObject)
    def registerGraph(self, item):
        self._graph_item = item
        self.refreshGraph()

    @Slot(str, str)
    def sendCommand(self, command_name, payload=""):
        self.commandRequested.emit(command_name, payload)

    # QML Property (Input Channels).
    @Property(float, notify=dataChanged)
    def oxygen(self): return self.channels["oxygen"]

    @Property(float, notify=dataChanged)
    def fuel(self): return self.channels["fuel"]

    @Property(float, notify=dataChanged)
    def nitrogen(self): return self.channels["nitrogen"]

    @Property(QVector3D, notify=dataChanged)
    def attitude(self): return self.channels["attitude"]

    @Property(str, notify=dataChanged)
    def activeGauge(self): return self._active_gauge.capitalize()

    @Property(float, notify=dataChanged)
    def altitude(self): return self.channels["altitude"]

    def cleanup(self):
        if self._thread.isRunning():
            QMetaObject.invokeMethod(self._worker, "stop", Qt.BlockingQueuedConnection)
            self._thread.quit()
            self._thread.wait(2000)