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

cdef extern from "animation.h":
	cdef class thor.animation.FrameAnimation [object PyFrameAnimationObject]:
		cdef danimation.FrameAnimation *p_this

	cdef class thor.animation.ColorAnimation [object PyColorAnimationObject]:
		cdef danimation.ColorAnimation *p_this

	cdef class thor.animation.FadeAnimation [object PyFadeAnimationObject]:
		cdef danimation.FadeAnimation *p_this
