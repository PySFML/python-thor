#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport dvectors

# TODO: replace PolarVector2Object with PolarVector2[object]
cdef class PolarVector2:
	cdef dvectors.PolarVector2Object *p_this

	def __cinit__(self, object radius, object angle):
		self.p_this = new dvectors.PolarVector2Object(radius, angle)

	def __dealloc__(self):
		del self.p_this

	property r:
		def __get__(self):
			return self.p_this.radius()

		def __set__(self, object r):
			self.p_this.radius(r)
			
	property phi:
		def __get__(self):
			return self.p_this.angle()

		def __set__(self, object phi):
			self.p_this.angle(phi)
