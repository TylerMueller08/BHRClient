import subprocess
import time
import win32gui, win32con
from PySide6.QtGui import QWindow

class EmbeddedWindow:
    @classmethod
    def create(cls) -> QWindow:
        process = subprocess.Popen(["notepad.exe"])
        
        hwnd = 0
        for _ in range(30):
            hwnd = win32gui.FindWindow("Notepad", None)
            if hwnd:
                break
            time.sleep(0.1)
            
        if not hwnd:
            raise RuntimeError("Could not find the Notepad window handle.")
            
        window = QWindow.fromWinId(hwnd)
        window._process = process 
        
        return window