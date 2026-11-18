"""
A channel is a singular named quantity sent across the link:

    INPUT    rocket -> dashboard    a measurement (pressure, temperature, state, etc.)
    OUTPUT   dashboard -> rocket    a command (arm, load, fire, etc.)
"""

from dataclasses import dataclass

INPUT = "input"
OUTPUT = "output"

@dataclass
class Channel:
    key: str           # ID used in Python/QML (e.g. "oxygen")
    label: str         # Text on GUI (e.g. "Oxygen Pressure")
    dataflow: str      # INPUT or OUTPUT
    quantity: str      # Type of value (e.g. "pressure", "state", "command")
    unit: str = ""     # Unit of measurement (e.g. "psi" or "%")

    # --- Inputs Only ---
    min: float = 0.0   # Minimum range for inputs.
    max: float = 0.0   # Maximum range for inputs.

    # --- Outputs Only ---
    code: int = -1     # Identifier for outgoing commands.


CHANNELS = [
    # --- Input Channels (Rocket -> Dashboard) ---
    Channel("oxygen", "Oxygen", INPUT, "pressure", "psi", 0.0, 100.0),
    Channel("fuel", "Fuel", INPUT, "pressure", "psi", 0.0, 100.0),
    Channel("nitrogen", "Nitrogen", INPUT, "pressure", "psi", 0.0, 100.0),
    Channel("altitude", "Altitude", INPUT, "altitude", "m", 0.0, 30000.0),

    # --- Output Channels (Dasboard -> Rocket) ---
    Channel("disarm", "DISARM SYSTEM", OUTPUT, "command", code=0),
    Channel("fire", "FIRE IGNITER", OUTPUT, "command", code=1),
]