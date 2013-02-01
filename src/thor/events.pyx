#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from libcpp.string cimport string

from pysfml cimport dwindow
from pysfml.window cimport Event, Window

cimport devents

class ActionType:
	HOLD = devents.actiontype.Hold
	PRESS_ONCE = devents.actiontype.PressOnce
	RELEASE_ONCE = devents.actiontype.ReleaseOnce

cdef class Action:
	cdef devents.Action *p_this

cdef Action wrap_action(devents.Action *p):
	cdef Action r = Action.__new__(Action)
	r.p_this = p
	return r

cdef class ActionMap:
	cdef devents.ActionMap[string] *p_this

	def __cinit__(self, Window window):
		self.p_this = new devents.ActionMap[string](window.p_window[0])

	def __dealloc__(self):
		del self.p_this

	def __getitem__(self, string key):
		cdef devents.Action *p = new devents.Action(dwindow.keyboard.A)
		p[0] = self.p_this[0][key]
		return wrap_action(p)

	def __setitem__(self, string key, Action value):
		self.p_this[0][key] = value.p_this[0]

	def update(self):
		self.p_this.update()

	def push_event(self, Event event):
		self.p_this.pushEvent(event.p_this[0])

	def clear_events(self):
		self.p_this.clearEvents()

	def remove_action(self, string id):
		self.p_this.removeAction(id)

	def clear_actions(self):
		self.p_this.clearActions()

	def is_active(self, string id):
		return self.p_this.isActive(id)

	def invoke_callbacks(self, system):
		pass


cdef public class Connection[type PyConnectionType, object PyConnectionObject]:
	cdef devents.Connection *p_this

	def __init__(self):
		self.p_this = new devents.Connection()

	def __dealloc__(self):
		del self.p_this

	def is_connected(self):
		return self.p_this.isConnected()

	def invalidate(self):
		self.p_this.invalidate()

	def disconnect(self):
		self.p_this.disconnect()

cdef Connection wrap_connection(devents.Connection *p):
	cdef Connection r = Connection.__new__(Connection)
	r.p_this = p
	return r

#cdef class EventSystem:
	#cdef devents.EventSystem[string] *p_this

	#def __cinit__(self, Window window):
		#self.p_this = new devents.ActionMap[string](window.p_window[0])

	#def __dealloc__(self):
		#del self.p_this

	#def __getitem__(self, string key):
		#cdef devents.Action *p = new devents.Action(dwindow.keyboard.A)
		#p[0] = self.p_this[0][key]
		#return wrap_action(p)

	#def __setitem__(self, string key, Action value):
		#self.p_this[0][key] = value.p_this[0]

	#def update(self):
		#self.p_this.update()

#cdef class MouseAction(Action): pass
#cdef class KeyboardAction(Action): pass
#cdef class JoystickAction(Action): pass



