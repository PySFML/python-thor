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
