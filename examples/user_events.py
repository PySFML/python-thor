from enum import IntEnum
from sfml import sf
from thor import th

# enumeration for unit orders in a strategy game
Command = IntEnum('Command', ('MOVE', 'ATTACK', 'HOLD_POSITION'))

# a user-defined event class, contains the name and command of a strategy game unit
class UnitEvent:
    def __init__(unit_name, order):
        self.unit_name = unit_name
        self.order = order

# function that returns the corresponding event identifier to an event
def get_event_id(event):
	return event.order

# callback for Command.MOVE
def on_move(event):
    print("Unit {0} moves.".format(event.unit_name))

# callback for Command.ATTACK
def on_attack(event):
    print("Unit {0} attacks.".format(event.unit_name))

# callback for Command.HOLD_POSITION
def on_hold_position(event):
    print("Unit {0} holds its position.".format(event.unit_name))

# create event system
system = EventSystem()

# connect event identifiers to the listeners
system.connect(Command.MOVE, on_move)
system.connect(Command.ATTACK, on_attack)
system.connect(Command.HOLD_POSITION, on_hold_position)

# create some events and fire them
system.trigger_event(UnitEvent("Tank", Command.ATTACK))
system.trigger_event(UnitEvent("Helicopter", Command.MOVE))
system.trigger_event(UnitEvent("Battleship", Command.ATTACK))
system.trigger_event(UnitEvent("Battleship", Command.HOLD_POSITION))
