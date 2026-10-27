# AI-Generated Demo

import random
from collections import deque
from PySide6.QtCore import QTimer, Signal, Slot, QObject, Property
from PySide6.QtQuick import QQuickPaintedItem
from PySide6.QtGui import QPainter
import pyqtgraph as pg

class PyQtGraphItem(QQuickPaintedItem):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setImplicitWidth(600)
        self.setImplicitHeight(300)
        
        pg.setConfigOptions(antialias=True)
        self.plot_widget = pg.PlotWidget()
        self.plot_widget.setBackground("#191a1b")
        self.plot_widget.showGrid(x=True, y=True, alpha=0.2)
        self.plot_widget.setTitle("Telemetry History - Oxygen", color="#cccccc", size="11pt")
        
        self.plot_widget.setLabel('left', 'Percent (%)', color='#cccccc')
        self.plot_widget.setLabel('bottom', 'Time (s)', color='#cccccc')
        
        self.curve = self.plot_widget.plot(pen=pg.mkPen(color='#004F98', width=2.5))

    def paint(self, painter: QPainter):
        w = int(self.width())
        h = int(self.height())
        if w > 0 and h > 0:
            self.plot_widget.resize(w, h)
            self.plot_widget.render(painter)

    def update_plot(self, x_data, y_data, active_gauge, color):
        self.plot_widget.setTitle(f"Telemetry History - {active_gauge}", color="#cccccc", size="11pt")
        self.curve.setPen(pg.mkPen(color=color, width=2.5))
        self.curve.setData(x_data, y_data)
        self.update()


class TelemetryController(QObject):
    oxygenChanged = Signal(float)
    fuelChanged = Signal(float)
    nitrogenChanged = Signal(float)
    activeGaugeChanged = Signal(str)

    def __init__(self):
        super().__init__()
        self._oxygen = 50.0
        self._fuel = 100.0
        self._nitrogen = 50.0
        self._active_gauge = "Oxygen"
        self.graph_item = None

        self.max_len = 60  # Keep last 60 seconds of history
        self.time_history = deque(maxlen=self.max_len)
        self.history = {
            "Oxygen": deque(maxlen=self.max_len),
            "Fuel": deque(maxlen=self.max_len),
            "Nitrogen": deque(maxlen=self.max_len),
        }
        self.seconds_elapsed = 0

        # Bulletproof 1-second QTimer that updates values live without thread crashes
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.tick)
        self.timer.start(1000)

    @Property(float, notify=oxygenChanged)
    def oxygen(self): return self._oxygen

    @Property(float, notify=fuelChanged)
    def fuel(self): return self._fuel

    @Property(float, notify=nitrogenChanged)
    def nitrogen(self): return self._nitrogen

    @Property(str, notify=activeGaugeChanged)
    def activeGauge(self): return self._active_gauge

    @Slot(QObject)
    def registerGraph(self, item):
        self.graph_item = item
        self.refresh_graph()

    @Slot(str)
    def selectGauge(self, name):
        if name in self.history:
            self._active_gauge = name
            self.activeGaugeChanged.emit(name)
            self.refresh_graph()

    def tick(self):
        # Generate random values between 0 and 100 (never negative)
        self._oxygen = max(0.0, min(100.0, self._oxygen + random.uniform(-4.0, 4.0)))
        self._fuel = max(0.0, min(100.0, self._fuel + random.uniform(-2.0, 2.0)))
        self._nitrogen = max(0.0, min(100.0, self._nitrogen + random.uniform(-3.0, 3.0)))

        # Emit change signals so QML gauges update instantly
        self.oxygenChanged.emit(self._oxygen)
        self.fuelChanged.emit(self._fuel)
        self.nitrogenChanged.emit(self._nitrogen)

        # Append to history buffers
        self.seconds_elapsed += 1
        self.time_history.append(self.seconds_elapsed)
        self.history["Oxygen"].append(self._oxygen)
        self.history["Fuel"].append(self._fuel)
        self.history["Nitrogen"].append(self._nitrogen)

        self.refresh_graph()

    def refresh_graph(self):
        if self.graph_item:
            colors = {"Oxygen": "#004F98", "Fuel": "#00984F", "Nitrogen": "#D97706"}
            color = colors.get(self._active_gauge, "#004F98")
            x = list(self.time_history)
            y = list(self.history[self._active_gauge])
            self.graph_item.update_plot(x, y, self._active_gauge, color)