import json, os

DEFAULTS = {
    "port": "COM3",
    "baud_rate": 115200,
    "data_bits": 8,
    "parity": "None",
    "stop_bits": 1.0
}

def load_settings(filepath="settings.json") -> dict:
    """Loads settings from JSON, falling back to defaults."""
    if not os.path.exists(filepath):
        print("[Config] '{filepath} not found. Using default settings.")
        return DEFAULTS

    try:
        with open(filepath, "r") as file:
            settings = json.load(file)

            # Merge defaults to ensure required keys exist.
            return {**DEFAULTS, **settings}
    except json.JSONDecodeError as e:
        print("[Config] Error parsing {filepath}: {e}. Using default settings.")
        return DEFAULTS