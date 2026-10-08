import subprocess
import time

import win32gui
import win32process

from PySide6.QtGui import QWindow


class EmbeddedWindow:
    @classmethod
    def create(cls) -> QWindow:
        process = subprocess.Popen([
            r"C:\Users\c30tyler.mueller\AppData\Local\Synnax\synnax-console.exe"
        ])
        hwnd = cls._wait_for_window(process)

        if not hwnd:
            process.terminate()
            raise RuntimeError("Could not find the Synnax window.")
        window = QWindow.fromWinId(hwnd)

        if window is None:
            process.terminate()
            raise RuntimeError("Qt could not wrap the Synnax HWND.")

        window._process = process
        window._hwnd = hwnd

        return window

    @staticmethod
    def _wait_for_window(process, timeout=10):
        deadline = time.time() + timeout

        while time.time() < deadline:
            hwnds = []

            def callback(hwnd, _):
                if not win32gui.IsWindowVisible(hwnd):
                    return

                _, pid = win32process.GetWindowThreadProcessId(hwnd)

                if pid == process.pid:
                    hwnds.append(hwnd)

            win32gui.EnumWindows(callback, None)

            if hwnds:
                return hwnds[0]

            time.sleep(0.1)

        return None