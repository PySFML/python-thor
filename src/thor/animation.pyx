#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

cimport danimation
cimport pysfml.dsystem
cimport pysfml.dgraphics

from libcpp.string cimport string

from pysfml.system cimport Time
from pysfml.graphics cimport Sprite

from graphics cimport ColorGradient

cdef pysfml.dsystem.IntRect rectangle_to_intrect(rectangle):
	l, t, w, h = rectangle
	return pysfml.dsystem.IntRect(l, t, w, h)


cdef public class FrameAnimation[type PyFrameAnimationType, object PyFrameAnimationObject]:
	cdef danimation.FrameAnimation *p_this

	def __cinit__(self):
		self.p_this = new danimation.FrameAnimation()

	def __dealloc__(self):
		del self.p_this

	def add_frame(self, float relative_duration, subrect):
		self.p_this.addFrame(relative_duration, rectangle_to_intrect(subrect))


cdef public class ColorAnimation[type PyColorAnimationType, object PyColorAnimationObject]:
	cdef danimation.ColorAnimation *p_this

	def __cinit__(self, ColorGradient gradient):
		self.p_this = new danimation.ColorAnimation(gradient.p_this[0])

	def __dealloc__(self):
		del self.p_this


cdef public class FadeAnimation[type PyFadeAnimationType, object PyFadeAnimationObject]:
	cdef danimation.FadeAnimation *p_this

	def __cinit__(self, float in_ratio, float out_ratio):
		self.p_this = new danimation.FadeAnimation(in_ratio, out_ratio)

	def __dealloc__(self):
		del self.p_this
