#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport dmath

from pysfml.dsystem cimport Vector2f
from pysfml.dgraphics cimport Color

cdef extern from "Thor/Particles.hpp" namespace "thor":
	cdef cppclass Particle:
		Particle(Time)
		Vector2f position
		Vector2f velocity
		float rotation
		float rotationSpeed
		Vector2f scale
		Color color
