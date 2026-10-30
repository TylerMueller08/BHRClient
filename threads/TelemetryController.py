from PySide6.QtCore import QObject, Signal, Slot, QMetaObject, Property, Qt, Q_ARG
from collections import deque

from threads.ChannelWorker import RocketChannelWorker

class TelemetryController(QObject):
    dataChanged = Signal()

    def __init__(self):
        super().__init__()

        # Channel properties for QML.
        self.channels = {
            "oxygen": 0.0,
            "fuel": 0.0,
            "nitrogen": 0.0
        }

        self._active_gauge = "Oxygen"
        self._graph_item = None

        # Graph History.
        self.max_len = 60
        self.time_history = deque(maxlen=self.max_len)
        self.history = {name: deque(maxlen=self.max_len) for name in self.channels}
        self.seconds_elapsed = 0

        # Thread & Worker.
        self._worker = RocketChannelWorker()
        self._worker.channelUpdated.connect(self.handleChannelUpdate)
        self._worker.connectionStateChanged.connect(self.handleConnectionStateChanged)
        self._worker.start()

    @Slot(bool, str)
    def handleConnectionStateChanged(self, connected, message):
        print(f"Connection Status: {connected} - {message}")

    @Slot(str, float)
    def handleChannelUpdate(self, name, value):
        self.channels[name] = value

        if name not in self.history:
            self.history[name] = deque(maxlen=self.max_len)

        if name == list(self.channels.keys())[0]:
            self.seconds_elapsed += 1
            self.time_history.append(self.seconds_elapsed)

        self.history[name].append(value)

        self.dataChanged.emit()
        self.refreshGraph()

    def refreshGraph(self):
        if self._graph_item and self._active_gauge in self.history:
            colors = {
                "Oxygen": "#004F98", 
                "Fuel": "#00984F", 
                "Nitrogen": "#D97706",
                "Engine_Temp": "#DC2626"
            }
            color = colors.get(self._active_gauge, "#004F98")
            
            x = list(self.time_history)
            y = list(self.history[self._active_gauge])
            self._graph_item.update_plot(x, y, self._active_gauge, color)

    @Slot(str)
    def selectGauge(self, name):
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
        # Called from QML for Launch/Abort buttons to trigger output channel.
        QMetaObject.invokeMethod(
            self._worker,
            "dispatch",
            Qt.QueuedConnection,
            Q_ARG(str, command_name),
            Q_ARG(str, payload)
        )

    # QML Property (Input Channels).
    @Property(float, notify=dataChanged)
    def oxygen(self): return self.channels.get("oxygen", 0.0)

    @Property(float, notify=dataChanged)
    def fuel(self): return self.channels.get("fuel", 0.0)

    @Property(float, notify=dataChanged)
    def nitrogen(self): return self.channels.get("nitrogen", 0.0)

    @Property(str, notify=dataChanged)
    def activeGauge(self): return self._active_gauge

    def cleanup(self):
        self._worker.stop()