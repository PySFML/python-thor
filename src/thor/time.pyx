#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport libcpp.sfml as sf
cimport libcpp.thor as th

from pysfml.system cimport Time, wrap_time
from pythor.events cimport wrap_connection

th.PyEval_InitThreads()

cdef class Timer:
	cdef th.Timer *p_timer

	def __init__(self):
		self.p_timer = new th.Timer()

	def __del__(self):
		del self.p_timer

	def start(self):
		self.p_timer.start()

	def stop(self):
		self.p_timer.stop()

	property running:
		def __get__(self):
			return self.p_timer.isRunning()

	property expired:
		def __get__(self):
			return self.p_timer.isExpired()

	def reset(self, Time time_limit):
		self.p_timer.reset(time_limit.p_this[0])

	def restart(self, Time time_limit):
		self.p_timer.restart(time_limit.p_this[0])

	property remaining_time:
		def __get__(self):
			cdef sf.Time* p = new sf.Time()
			p[0] = self.p_timer.getRemainingTime()
			return wrap_time(p)


cdef class CallbackTimer(Timer):
	cdef th.CallbackTimer *p_this

	def __init__(self):
		self.p_this = new th.CallbackTimer()
		self.p_timer = <th.Timer*>self.p_this

	def __del__(self):
		del self.p_this

	def update(self):
		with nogil: self.p_this.update()

	def connect(self, function):
		cdef th.Connection *p = new th.Connection()
		p[0] = th.CallbackTimer_connect(self.p_this, function)
		return wrap_connection(p)

	def clear_connections(self):
		self.p_this.clearConnections()


cdef class StopWatch:
	cdef th.StopWatch *p_this

	def __cinit__(self):
		self.p_this = new th.StopWatch()

	def __dealloc__(self):
		del self.p_this

	def start(self):
		self.p_this.start()

	def stop(self):
		self.p_this.stop()

	property running:
		def __get__(self):
			return self.p_this.isRunning()

	def reset(self):
		self.p_this.reset()

	def restart(self):
		self.p_this.restart()

	property elapsed_time:
		def __get__(self):
			cdef sf.Time* p = new sf.Time()
			p[0] = self.p_this.getElapsedTime()
			return wrap_time(p)
