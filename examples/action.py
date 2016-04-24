
from enum import IntEnum
from sfml import sf
from thor import th

# enumeration for user-defined actions

# todo: use uppercase ?
MyAction = IntEnum('MyAction', ('RUN', 'JETPACK', 'SHOOT', 'QUIT', 'RESIZE'))

# callback function for Resize, Shoot (mouse click) and Run (joystick axis) actions
def on_resize(context):
    # the sf.Event member variable called type has always the value sf.Event.Resized, as specified in the thor::Action
    # constructor. Since the Resize action has been triggered by an sf::Event (and not by a sf::Keyboard, sf::Mouse or
    # sf::Joystick), we can also be sure that context.event is no null pointer.
    print("Resized!   New size = ({0}, {1})".format(context.event.size.x, context.event.size.y))

def on_shoot(context):
    # context.window is the sf::Window passed to the th.ActionMap constructor.
    # It can be used for mouse input relative to a window, as follows:
    mouse_position = sf.Mouse.get_position(context.window)
    print("Shoot: {0}.".format(mouse_position))

    # warning: original contains thor::toString
    #std::cout << "Shoot: " << thor::toString(mousePosition) << std::endl;

def on_run():
    # since no event is associated with a joystick axis action, we access the global sf.Joystick
    axis_position = sf.Joystick.getAxisPosition(0, sf.Joystick.X)
    print("Run at {0}% speed.".format(axis_position))


# create and initialize window
window = sf.Window(sf.VideoMode(400, 300), "Thor - Action")
window.framerate_limit = 20
window.key_repeat_enabled = False

# create th.ActionMap that maps MyAction values to th.Action instances
map_ = th.ActionMap()

# JETPACK: press one of the shift keys and J (realtime input)
lshift_action = th.Action.from_keyboard_key(sf.Keyboard.L_SHIFT)
rshift_action = th.Action.from_keyboard_key(sf.Keyboard.R_SHIFT)
j_action = th.Action.from_keyboard_key(sf.Keyboard.J)
map_[MyAction.JETPACK] = th.Action.andOperator(th.Action.orOperator(lshift_action, rshift_action), j_action)

# RUN: displace X axis of joystick number 0 by more than 30% in either direction
#map[Run] = Action(thor::joystick(0).axis(sf::Joystick::X).above(30.f))
        #|| Action(thor::joystick(0).axis(sf::Joystick::X).below(-30.f));

# SHOOT: press left mouse button or button 2 of joystick number 0 (single events)
mouseleft_action = th.Action.from_mouse_button(sf.Mouse.LEFT, th.ActionType.PRESS_ONCE)
#joystickbutton_action = th.Action.from_joystick_button(foobar)
#map_[MyAction.SHOOT] = th.Action.orOperator(mouseleft_action, joystickbutton_action)
#map_[MyAction.SHOOT] = mouseleft_action

#map[Shoot] = Action(sf::Mouse::Left, Action::PressOnce) || Action(thor::joystick(0).button(2), Action::PressOnce);

# QUIT: release the escape key or click the [X] (single events)
escape_key_action = th.Action.from_keyboard_key(sf.Keyboard.ESCAPE, th.ActionType.RELEASE_ONCE)
close_action = th.Action.from_event_type(sf.EventType.CLOSED)
map_[MyAction.QUIT] = th.Action.orOperator(escape_key_action, close_action)

# RESIZE: change window size (single event)
map_[MyAction.RESIZE] = th.Action.from_event_type(sf.EventType.RESIZED);

#// Create thor::EventSystem to connect Resize and Shoot actions with callbacks
#// Use connect0() instead of connect() when callback has no parameter
#thor::ActionMap<MyAction>::CallbackSystem system;
#system.connect(Resize, &onResize);
#system.connect(Shoot, &onShoot);
#system.connect0(Run, &onRun);

# main loop
running = True

while running:
    # generate new actions (calls window.pollEvent(...))
    map_.update(window)

    # check which actions are currently in effect, react correspondingly
    if map_.is_active(MyAction.JETPACK):
        print("Jetpack!")
    if map_.is_active(MyAction.QUIT):
        running = False

    ## forward actions to callbacks: Invokes onResize() in case of sf::Event::Resized events
    #map_.invokeCallbacks(system, window)

    # update window
    window.display()
