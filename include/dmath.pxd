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
from pysfml.dgraphics cimport Color

cimport distributions

cdef extern from "Thor/Math.hpp" namespace "thor":

	cdef cppclass Distribution[T]:
		Distribution(T)
		T operator ()()

cdef extern from "DistributionAPI.hpp" namespace "":

	cdef cppclass DistributionAPI:
		object operator ()()
		Distribution[float]    getFloatFunctor()
		Distribution[Vector2f] getVector2Functor()
		Distribution[Time]     getTimeFunctor()
		Distribution[Color]    getColorFunctor()

	cdef cppclass DistributionObject:
		DistributionObject(object)

		Distribution[float]    getFloatFunctor()
		Distribution[Vector2f] getVector2Functor()
		Distribution[Time]     getTimeFunctor()
		Distribution[Color]    getColorFunctor()

	cdef cppclass DistributionFloat:
		DistributionFloat(Distribution[float])

		Distribution[float]    getFloatFunctor()
		Distribution[Vector2f] getVector2Functor()
		Distribution[Time]     getTimeFunctor()
		Distribution[Color]    getColorFunctor()

	cdef cppclass DistributionVector2:
		DistributionVector2(Distribution[Vector2f])

		Distribution[float]    getFloatFunctor()
		Distribution[Vector2f] getVector2Functor()
		Distribution[Time]     getTimeFunctor()
		Distribution[Color]    getColorFunctor()

	cdef cppclass DistributionTime:
		DistributionTime(Distribution[Time])

		Distribution[float]    getFloatFunctor()
		Distribution[Vector2f] getVector2Functor()
		Distribution[Time]     getTimeFunctor()
		Distribution[Color]    getColorFunctor()

	cdef cppclass DistributionColor:
		DistributionColor(Distribution[Color])

		Distribution[float]    getFloatFunctor()
		Distribution[Vector2f] getVector2Functor()
		Distribution[Time]     getTimeFunctor()
		Distribution[Color]    getColorFunctor()

cdef extern from "Thor/Math.hpp" namespace "thor":

	int random(int, int)
	int randomDev(int, int)
	float random(float, float)
	float randomDev(float, float)
	void setRandomSeed(unsigned long)

	cdef cppclass Edge[V]:
		Edge(V&, V&)
		V operator[](unsigned int)

	cdef cppclass Triangle[V]:
		Triangle(V&, V&, V&)
		V& operator[](unsigned int)


cdef extern from "triangulation.hpp" namespace "":
	#Triangle[void*]* Triangle_initialization(void*, void*, void*)
	#void* Triangle_get(Triangle[void*]&, unsigned int)

	object triangulate(object)
	void triangulateConstrained(object)
	void triangulatePolygon(object)
