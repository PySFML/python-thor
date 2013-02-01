#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from danimation cimport FrameAnimation, ColorAnimation, FadeAnimation
from dparticles cimport shared_ptr
from dparticles cimport AnimationAffector

cdef extern from "Thor/Particles.hpp" namespace "thor::AnimationAffector":
	ctypedef shared_ptr[AnimationAffector] Ptr
	Ptr create(ColorAnimation)
	Ptr create(FadeAnimation)
