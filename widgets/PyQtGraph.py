from PySide6.QtCore import Slot
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
        """Renders the PyQtGraph widget onto the QML Quick Painted Item layer."""
        w = int(self.width())
        h = int(self.height())
        if w > 0 and h > 0:
            self.plot_widget.resize(w, h)
            self.plot_widget.render(painter)

    @Slot(list, list, str, str)
    def update_plot(self, x_data, y_data, active_gauge, color):
        """Updates graph curves, titles, and theme colors dynamically."""
        self.plot_widget.setTitle(f"Telemetry History - {active_gauge}", color="#cccccc", size="11pt")
        self.curve.setPen(pg.mkPen(color=color, width=2.5))
        self.curve.setData(x_data, y_data)
        self.update()