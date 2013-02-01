#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from pysfml.dsystem cimport Vector2f, Time
from pysfml.dgraphics cimport IntRect
from pysfml.dgraphics cimport Texture, Color

from dgraphics cimport ColorGradient

cdef extern from "Thor/Animation.hpp" namespace "thor":

	cdef cppclass FrameAnimation:
		FrameAnimation()
		void addFrame(float, IntRect&)

	cdef cppclass ColorAnimation:
		ColorAnimation(ColorGradient&)

	cdef cppclass FadeAnimation:
		FadeAnimation(float, float)

	cdef cppclass Animator[Animated, Id]:
		Animator()
		void addAnimation(Id&, FrameAnimation&, Time)
		void addAnimation(Id&, ColorAnimation&, Time)
		void addAnimation(Id&, FadeAnimation&, Time)
		void playAnimation(Id&)
		void playAnimation(Id&, bint)
		void stopAnimation()
		bint isPlayingAnimation()
		void update(Time)
		void animate(Animated&)
