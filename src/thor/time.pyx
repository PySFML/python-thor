#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from pysfml cimport dsystem
cimport dtime

from pysfml.system cimport Time, wrap_time



cdef class Timer:
	cdef dtime.Timer *p_this

	def __cinit__(self, *args, **kwargs):
		self.p_this = new dtime.Timer()
		
	def __dealloc__(self):
		del self.p_this
		
	def start(self):
		self.p_this.start()

	def stop(self):
		self.p_this.stop()
		
	property running:
		def __get__(self):
			return self.p_this.isRunning()
			
	property expired:
		def __get__(self):
			return self.p_this.isExpired()

	def reset(self, Time time_limit):
		self.p_this.reset(time_limit.p_this[0])

	def restart(self, Time time_limit):
		self.p_this.restart(time_limit.p_this[0])

	property remaining_time:
		def __get__(self):
			cdef dsystem.Time* p = new dsystem.Time()
			p[0] = self.p_this.getRemainingTime()
			return wrap_time(p)

cdef class StopWatch:
	cdef dtime.StopWatch *p_this

	def __cinit__(self, *args, **kwargs):
		self.p_this = new dtime.StopWatch()
		
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
			cdef dsystem.Time* p = new dsystem.Time()
			p[0] = self.p_this.getElapsedTime()
			return wrap_time(p)
