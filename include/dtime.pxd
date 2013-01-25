#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from pysfml.dsystem cimport Time
from devents cimport Connection

cdef extern from "Python.h" namespace "":
	void PyEval_InitThreads()

cdef extern from "Thor/Time.hpp" namespace "thor":

	cdef cppclass Timer:
		Timer()
		Time getRemainingTime()
		bint isRunning()
		bint isExpired()
		void start()
		void stop()
		void reset(Time)
		void restart(Time)

	cdef cppclass CallbackTimer:
		CallbackTimer()
		void update() nogil
		# see "CallbackTimer_connect" for Connection connect(Listener&)
		void clearConnections()


	cdef cppclass StopWatch:
		StopWatch()
		Time getElapsedTime()
		bint isRunning()
		void start()
		void stop()
		void reset()
		void restart()

cdef extern from "listeners.hpp" namespace "":
	Connection CallbackTimer_connect(CallbackTimer*, object)
