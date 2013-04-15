#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from libcpp.sfml cimport Vector2f, Time

# The following code should be replaced by `from dmath cimport Distribution`
# but with the current Cython compiler (v0.17.4) it results a crash:
# Output: include/distributions.pxd:22:20: Compiler crash in
# AnalyseDeclarationsTransform
cdef extern from "Thor/Math.hpp" namespace "thor":
	cdef cppclass Distribution[T]:
		Distribution(T)

cdef extern from "Thor/Math.hpp" namespace "thor::Distributions":
	Distribution[float] uniform(float, float)
	Distribution[Time]  uniform(Time, Time)
	Distribution[Vector2f] rect(Vector2f, Vector2f)
	Distribution[Vector2f] circle(Vector2f, float)
	Distribution[Vector2f] deflect(Vector2f, float)
