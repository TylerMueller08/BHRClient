from PySide6.QtCore import QObject, Signal, Slot
import threading, random

class RocketChannelWorker(QObject):
    channelUpdated = Signal(str, float) # Input channel values.
    connectionStateChanged = Signal(bool, str) # Status of rocket connection.

    def __init__(self):
        super().__init__()
        self._running = False
        self._thread = None
        self._stop_event = threading.Event()

        # Defining channels and assigning default states.
        self.input_channels = {
            "oxygen": 0.0,
            "fuel": 0.0,
            "nitrogen": 0.0
        }

    def start(self):
        if self._running:
            return
        self._running = True
        self._stop_event.clear()
        self._thread = threading.Thread(target=self._run_loop, daemon=True)
        self._thread.start()

    def _run_loop(self):
        self.connectionStateChanged.emit(True, "Rocket Connected")

        while self._running and not self._stop_event.is_set():
            try:
                # Simulation only.
                # Read incoming bytes instead of random generation.
                self.input_channels["oxygen"] = round(random.uniform(75.0, 95.0), 1)
                self.input_channels["fuel"] = round(random.uniform(60.0, 90.0), 1)
                self.input_channels["nitrogen"] = round(random.uniform(40.0, 60.0), 1)
    
                for name, value in self.input_channels.items():
                    self.channelUpdated.emit(name, value)
    
            except Exception as e:
                self.connectionStateChanged.emit(False, str(e))

            self._stop_event.wait(1.0)

        self.connectionStateChanged.emit(False, "Rocket Disconnected")

    @Slot()
    def stop(self):
        self._running = False
        self._stop_event.set()
        if self._thread and self._thread.is_alive():
            self._thread.join(timeout=2.0)

    @Slot(str, str)
    def dispatch(self, command_name, payload):
        # Sends a command channel (e.g. Launch, Abort, Terminal, or Valves)
        print(f"Sending Command {command_name} with payload {payload}")
        # TODO: Implement socket write.