#-------------------------------------------------------------------------------
# PyThor - Python bindings for Thor
# Copyright (c) 2013-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is provided 'as-is', without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from the
# use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software in a
#    product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
#
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
#
# 3. This notice may not be removed or altered from any source distribution.
#-------------------------------------------------------------------------------

# fix-me:
# - investigate how to support overloading of and, or and not operator in
# python; temporarily I implemented class methods andOperator(a, b)
# - fix ActionMap getitem operator
# - investigate thor::joystick(0).axis(Foo).above(30)

cimport sfml as sf
cimport thor as th

from pysfml.window cimport Window
from pysfml.window cimport import_sfml__window

#__all__ = ['ActionType', 'Action', 'ActionMap', 'EventSystem', 'Connection']
#__all__ = ['EventSystem']
__all__ = ['JoystickButton', 'JoystickAxis', 'ActionType', 'Action', 'eventAction', 'realtimeAction', 'ActionMap']

cdef extern from "Input.hpp":

    th.Action* actionAndOperator(th.Action*, th.Action*)
    th.Action* actionOrOperator(th.Action*, th.Action*)
    th.Action* actionNotOperator(th.Action*)

    th.Action* actionEventAction(object)
    th.Action* actionRealtimeAction(object)

    cdef cppclass ActionId:
        ActionId(object)
        object get()

    cdef cppclass EventId:
        EventId(object)
        object get()

    cdef cppclass Event:
        Event()
        Event(object)
        object get()
        void set(object)

#    th.Connection connect(th.EventSystem[Event, EventId]*, object, object)

class ActionType:
    HOLD = th.action.Hold
    PRESS_ONCE = th.action.PressOnce
    RELEASE_ONCE = th.action.ReleaseOnce

cdef class JoystickButton:
    cdef th.JoystickButton* p_this

    def __cinit__(self, joystick_id, button):
        self.p_this = new th.JoystickButton(joystick_id, button)

    def __dealloc__(self):
        del self.p_this

    property joystick_id:
        def __get__(self):
            return self.p_this.joystickId

        def __set__(self, joystick_id):
            self.p_this.joystickId = joystick_id

    property button:
        def __get__(self):
            return self.p_this.button

        def __set__(self, button):
            self.p_this.button = button

cdef class JoystickAxis:
    cdef th.JoystickAxis* p_this

    def __cinit__(self, joystick_id, axis, threshold, above):
        self.p_this = new th.JoystickAxis(joystick_id, axis, threshold, above)

    def __dealloc__(self):
        del self.p_this

    property joystick_id:
        def __get__(self):
            return self.p_this.joystickId

        def __set__(self, joystick_id):
            self.p_this.joystickId = joystick_id

    property axis:
        def __get__(self):
            return self.p_this.axis

        def __set__(self, axis):
            self.p_this.axis = axis

    property button:
        def __get__(self):
            return self.p_this.threshold

        def __set__(self, threshold):
            self.p_this.threshold = threshold

    property above:
        def __get__(self):
            return self.p_this.above

        def __set__(self, above):
            self.p_this.above = above

cdef class Action:
    cdef th.Action *p_this

    def __init__(self):
        raise UserWarning("Use a specific constructor")

    def __dealloc__(self):
        del self.p_this

    @classmethod
    def andOperator(cls, Action a, Action b):
        cdef th.Action *p = actionAndOperator(a.p_this, b.p_this)
        return wrap_action(p)

    @classmethod
    def orOperator(cls, Action a, Action b):
        cdef th.Action *p = actionOrOperator(a.p_this, b.p_this)
        return wrap_action(p)

    @classmethod
    def notOperator(cls, Action a):
        cdef th.Action *p = actionNotOperator(a.p_this)
        return wrap_action(p)

    @classmethod
    def from_keyboard_key(cls, sf.keyboard.Key key, th.action.ActionType action=ActionType.HOLD):
        cdef th.Action *p = new th.Action(key, action)
        return wrap_action(p)

    @classmethod
    def from_mouse_button(cls, sf.mouse.Button mouse_button, th.action.ActionType action=ActionType.HOLD):
        cdef th.Action *p = new th.Action(mouse_button, action)
        return wrap_action(p)

    @classmethod
    def from_joystick_button(cls, JoystickButton joystick_state, th.action.ActionType action=ActionType.HOLD):
        cdef th.Action *p = new th.Action(joystick_state.p_this[0], action)
        return wrap_action(p)

    @classmethod
    def from_joystick_axis(cls, JoystickAxis joystick_axis):
        cdef th.Action *p = new th.Action(joystick_axis.p_this[0])
        return wrap_action(p)

    @classmethod
    def from_event_type(cls, sf.event.EventType event_type):
        cdef th.Action *p = new th.Action(event_type)
        return wrap_action(p)

cdef api object wrap_action(th.Action *p):
    cdef Action r = Action.__new__(Action)
    r.p_this = p
    return r

def eventAction(filter_):
    cdef th.Action *p = actionEventAction(filter_)
    return wrap_action(p)

def realtimeAction(filter_):
    cdef th.Action *p = actionRealtimeAction(filter_)
    return wrap_action(p)

cdef class ActionMap:
    cdef th.ActionMap[ActionId] *p_this

    def __init__(self):
        self.p_this = new th.ActionMap[ActionId]()

    def __dealloc__(self):
        del self.p_this

##    Action& operator[] (const ActionId&)
#    def __getitem__(self, id_):
#        pass

    def __setitem__(self, id_, Action action):
        self.p_this[0][ActionId(id_)] = action.p_this[0]

    def update(self, Window window):
        self.p_this.update(window.p_window[0])

    def push_event(self, event):
        raise NotImplemented()

    def clear_events(self):
        self.p_this.clearEvents()

    def remove_action(self, id_):
        self.p_this.removeAction(ActionId(id_))

    def clear_actions(self):
        self.p_this.clearActions()

    def is_active(self, id_):
        return self.p_this.isActive(ActionId(id_))

#    void invokeCallbacks (CallbackSystem &system, sf::Window *window) const
#    def invoke_callbacks(self, CallbackSystem system, Window window):
#        pass

#cdef class EventSystem:
#    cdef th.EventSystem[Event, EventId] *p_this

#    def __init__(self):
#        self.p_this = new th.EventSystem[Event, EventId]()

#    def __dealloc__(self):
#        del self.p_this

#    def trigger_event(self, event):
#        self.p_this.triggerEvent(Event(event))

#    def connect(self, trigger, listener):
##        self.p_this.connect(Event(trigger), EventListener(listener))
#        connect(self.p_this, trigger, listener)

#    def clear_connections(self, identifier):
#        self.p_this.clearConnections(EventId(identifier))

#    def clear_all_connections(self):
#        self.p_this.clearAllConnections()

#####################
#####################
#####################
#cdef public class Connection[type PyConnectionType, object PyConnectionObject]:
#	cdef th.Connection *p_this

#	def __init__(self):
#		self.p_this = new th.Connection()

#	def __dealloc__(self):
#		del self.p_this

#	def is_connected(self):
#		return self.p_this.isConnected()

#	def invalidate(self):
#		self.p_this.invalidate()

#	def disconnect(self):
#		self.p_this.disconnect()
