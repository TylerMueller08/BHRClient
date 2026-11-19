from comms.config import load_settings
import serial

class XbeeReader():
    def __init__(self):
        super().__init__()
        self._running = False
        self.settings = load_settings()

    def start(self):
        self._running = True

        port = self.settings["port"]
        baud = self.settings["baud"]

        print("[Telemetry] Connecting to {port} at {baud} baud.")

        try:
            serial = serial.Serial(
                port = port,
                baudrate = baud,
                bytesize = self.settings["data_bits"],
                timeout = 1
            )

            while self._running:
                if serial.in_waiting:
                    line = serial.readline().decode("utf-8").strip()
                    # Emit data as received.
        except Exception as e:
            # Fallback to simulation, or close.
            pass

    def stop(self):
        self._running = False