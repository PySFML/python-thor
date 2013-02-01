#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from pysfml.dwindow cimport Event, Window
from pysfml.dwindow cimport keyboard, mouse, joystick, event

cimport actiontype



cdef extern from "Thor/Events.hpp" namespace "thor":

	cdef cppclass Action:
		Action(keyboard.Key)
		Action(mouse.Button)
		#Action(joystick)
		Action(event.EventType)

  	#Action (sf::Keyboard::Key key, ActionType action=Hold)
 	#Construct key action.
 	#Action (sf::Mouse::Button mouseButton, ActionType action=Hold)
 	#Construct mouse button action.
 	#Action (Joystick joystickState, ActionType action=Hold)
 	#Construct joystick button action.
 	#Action (sf::Event::EventType eventType)
 	#Construct SFML event action.

	cdef cppclass ActionMap[ActionId]:
		ActionMap(Window&)
		void update()
		void pushEvent(Event&)
		void clearEvents()
		Action& operator[](ActionId&)
		void removeAction(ActionId&)
		void clearActions()
		bint isActive(ActionId&)
		#void invokeCallbacks(CallbackSystem&)

	cdef cppclass Connection:
		Connection()
		bint isConnected()
		void invalidate()
		void disconnect()

	cdef cppclass EventSystem[Event, EventId]:
		EventSystem()
		void triggerEvent(Event&)
		#Connection connect(EventId&, Listener&)
		void clearConnections(EventId)
		void clearAllConnections()
