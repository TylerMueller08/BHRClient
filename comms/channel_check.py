from comms.channel import Input, Output

def _need(condition, message):
    if not condition:
        raise ValueError(message)

def check(channels):
    inputs = [channel for channel in channels if isinstance(channel, Input)]
    outputs = [channel for channel in channels if isinstance(channel, Output)]

    _need(len(inputs) + len(outputs) == len(channels), "Every channel must be an Input or an Output.")
    _need(len({channel.key for channel in channels}) == len(channels), "Two channels share an identical key.")
    _need(len({channel.code for channel in outputs}) == len(outputs), "Two outputs share an identical command code.")
    _need(all(channel.max > channel.min for channel in inputs if channel.is_gauge), "A gauge needs a greater maximum than minimum.")
    _need(any(channel.is_guage for channel in inputs), "Must have at least one gauge input.")
    