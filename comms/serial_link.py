from PySide6.QtCore import QIODevice, QObject, Signal
from PySide6.QtSerialPort import QSerialPort

MAX_LENGTH = 4096 # Characters

class SerialLink(QObject):
    lineReceived = Signal(str)
    stateChange = Signal(bool, str)
    error = Signal(str)

    def __init__(self, port, baud):
        super().__init__()
        self._port, self._baud = port, baud
        self._buffer = bytearray()
        self._serial = QSerialPort(self)
        self._serial.setPortName(port)
        self._serial.setBaudRate(baud)
        self._serial.readyRead.connect(self._on_data)
        self._serial.errorOccurred.connect(self._on_error)

    def open(self):
        self._buffer.clear()
        if self._serial.open(QIODevice.OpenModeFlag.ReadWrite):
            self.stateChange.emit(True, f"Connected to {self._port} at {self._baud} baud.")
        else:
            self.error.emit(f"Could not open {self._port}: {self._serial.errorString()}")
            self.stateChange.emit(False, "Disconnected")

    def close(self, message="Disconnected"):
        if self._serial.isOpen():
            self._serial.close()
            self.stateChange.emit(False, message)

    def send(self, data):
        return self._serial.isOpen() and self._serial.write(data) == len(data)

    def _on_data(self):
        self._buffer += bytes(self._serial.readAll())
        *lines, rest = self._buffer.split(b"\n")
        self._buffer = rest if len(rest) < MAX_LENGTH else bytearray()
        for line in lines:
            self.lineReceived.emit(line.decode(errors="replace"))

    def _on_error(self, err):
        if err == QSerialPort.SerialPortError.ResourceError:
            self.error.emit(f"{self._port}: {self._serial.errorString()}")
            self.close("Connection lost")