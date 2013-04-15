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

cimport libcpp.sfml as sf
cimport libcpp.thor as th

from pysfml.system cimport Time
from pysfml.graphics cimport Sprite

from pysfml.graphics cimport to_intrect
from pythor.graphics cimport ColorGradient


cdef public class FrameAnimation[type PyFrameAnimationType, object PyFrameAnimationObject]:
	cdef th.FrameAnimation *p_this

	def __cinit__(self):
		self.p_this = new th.FrameAnimation()

	def __dealloc__(self):
		del self.p_this

	def add_frame(self, float relative_duration, subrect):
		self.p_this.addFrame(relative_duration, to_intrect(subrect))


cdef public class ColorAnimation[type PyColorAnimationType, object PyColorAnimationObject]:
	cdef th.ColorAnimation *p_this

	def __cinit__(self, ColorGradient gradient):
		self.p_this = new th.ColorAnimation(gradient.p_this[0])

	def __dealloc__(self):
		del self.p_this


cdef public class FadeAnimation[type PyFadeAnimationType, object PyFadeAnimationObject]:
	cdef th.FadeAnimation *p_this

	def __cinit__(self, float in_ratio, float out_ratio):
		self.p_this = new th.FadeAnimation(in_ratio, out_ratio)

	def __dealloc__(self):
		del self.p_this

ctypedef fused AnimationFunction:
	FrameAnimation
	ColorAnimation
	FadeAnimation

cdef class Animator:
	cdef th.Animator[sf.Sprite, string] *p_this

	def __cinit__(self, *args, **kwargs):
		self.p_this = new th.Animator[sf.Sprite, string]()

	def __dealloc__(self):
		del self.p_this

	def add_animation(self, string id, AnimationFunction animation, Time duration):
		if AnimationFunction is FrameAnimation:
			self.p_this.addAnimation(<string>id, (<th.FrameAnimation*>animation.p_this)[0], (<sf.Time*>duration.p_this)[0])
		elif AnimationFunction is ColorAnimation:
			self.p_this.addAnimation(<string>id, (<th.ColorAnimation*>animation.p_this)[0], (<sf.Time*>duration.p_this)[0])
		elif AnimationFunction is FadeAnimation:
			self.p_this.addAnimation(<string>id, (<th.FadeAnimation*>animation.p_this)[0], (<sf.Time*>duration.p_this)[0])

	def play_animation(self, string id, bint loop=False):
		self.p_this.playAnimation(id, loop)

	def stop_animation(self):
		self.p_this.stopAnimation()

	def is_playing_animation(self):
		return self.p_this.isPlayingAnimation()

	def update(self, Time dt):
		self.p_this.update(dt.p_this[0])

	def animate(self, Sprite animated):
		self.p_this.animate(animated.p_this[0])
