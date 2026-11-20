from PySide6.QtSerialPort import QSerialPortInfo

TEST_PORT = "TEST MODE"

def list_ports():
    return [port.portName() for port in QSerialPortInfo.availablePorts()] + [TEST_PORT]