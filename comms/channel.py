"""
A channel is a singular named quantity sent across the link:

    INPUT    rocket -> dashboard    a measurement (pressure, temperature, state, etc.)
    OUTPUT   dashboard -> rocket    a command (arm, load, fire, etc.)
"""

from dataclasses import dataclass, field

@dataclass
class Input:
    key: str
    label: str
    quantity: str
    unit: str
    min: float = 0
    max: float = 100
    decimals: int = 1
    color: str = "#CCCCCC"
    states: dict = field(default_factor=dict)

    @property
    def is_gauge(self):
        return not self.states

    def to_qml(self):
        return {
            "key": self.key, "label": self.label, "quantity": self.quantity, "unit": self.unit,
            "min": self.min, "max": self.max, "decimals": self.decimals, "color": self.color,
            "states": {str(v): {"text": text, "color": color} for v, (text, color) in self.states.items()},
        }

@dataclass
class Output:
    key: str
    label: str
    code: int
    color: str = "#4A4E57"   # Sent as CMD,<code>,<id>
    confirm: bool = False      # Hold button to send command.

    def to_qml(self):
        return {"key": self.key, "label": self.label, "color": self.color, "confirm": self.confirm}
