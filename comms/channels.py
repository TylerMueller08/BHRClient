from comms.channel import Input, Output
from comms.states import GOOD_BAD, SYSTEM_STATES

CHANNELS = [
    Input("oxygen", "Oxygen", "percent", "%", min=0, max=2500, color="#004F98"),
    Input("fuel", "Fuel", "percent", "%", min=0, max=50,   color="#00984F", decimals=2),
    Input("nitrogen", "Nitrogen", "percent", "%", min=0, max=120,  color="#D97706"),
    Input("state", "System State", "state", states=SYSTEM_STATES),

    Output("disarm", "DISARM", code=0, color="#4A4F57"),
    Output("arm", "ARM", code=1, color="#A86A00"),
    Output("load", "LOAD", code=2, color="#1E6FD9"),
    Output("loaded", "LOADED", code=3, color="#8E44AD"),
    Output("fire", "FIRE", code=4, color="#CC0000", confirm=True),
    Output("purge", "PURGE", code=5, color="#00807F"),
    Output("purged", "PURGED", code=6, color="#2E7D32"),
]
