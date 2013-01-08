#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

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

	cdef cppclass StopWatch:
		StopWatch()
		Time getRemainingTime()
		bint isRunning()
		void start()
		void stop()
		void reset()
		void restart()
