from PySide6.QtCore import Qt, Slot
from PySide6.QtGui import QPainter, QPixmap
from PySide6.QtQuick import QQuickPaintedItem
import pyqtgraph as pg


class PyQtGraphItem(QQuickPaintedItem):
    MIN_W, MIN_H = 480, 300

    def __init__(self, parent=None):
        super().__init__(parent)
        self.plot_widget = None
        self._pixmap = QPixmap()

        pg.setConfigOptions(antialias=True)
        plot = pg.PlotWidget()
        plot.setBackground("#191a1b")
        plot.showGrid(x=True, y=True, alpha=0.2)
        plot.setTitle("Oxygen", color="#cccccc", size="11pt")
        plot.setLabel("left", "Percent (%)", color="#cccccc")
        plot.setLabel("bottom", "Time (s)", color="#cccccc")
        self.curve = plot.plot(pen=pg.mkPen(color="#004F98", width=2.5))

        plot.setAttribute(Qt.WidgetAttribute.WA_DontShowOnScreen, True)
        plot.setAttribute(Qt.WidgetAttribute.WA_QuitOnClose, False)
        plot.show()
        self.plot_widget = plot

        self.setAntialiasing(True)
        self.setImplicitWidth(600)
        self.setImplicitHeight(300)

    def _render_plot(self):
        if self.plot_widget:
            self._pixmap = self.plot_widget.grab()
            self.update()

    def geometryChange(self, new_geometry, old_geometry):
        super().geometryChange(new_geometry, old_geometry)
        w, h = new_geometry.width(), new_geometry.height()
        if self.plot_widget and w > 0 and h > 0:
            scale = min(1.0, w / self.MIN_W, h / self.MIN_H)
            self.plot_widget.resize(int(w / scale), int(h / scale))
            self._render_plot()

    def paint(self, painter: QPainter):
        if not self._pixmap.isNull():
            return
        pixmap = self.plot_widget.grab()
        painter.setRenderHint(QPainter.RenderHint.SmoothPixmapTransform, True)
        painter.drawPixmap(self.boundingRect().toRect(), pixmap)

    @Slot(list, list, str, str)
    def update_plot(self, x_data, y_data, active_gauge, color):
        if not self.plot_widget:
            return
        self.plot_widget.setTitle(f"{active_gauge}", color="#cccccc", size="11pt")
        self.curve.setPen(pg.mkPen(color=color, width=2.5))
        self.curve.setData(x_data, y_data)
        self.update()