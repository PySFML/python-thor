#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from pysfml.dsystem cimport Vector2f
from pysfml.dgraphics cimport Color, Shape, ConvexShape

cdef extern from "Thor/Shapes.hpp" namespace "thor":

	cdef cppclass Arrow:
		Arrow()
		Arrow(Vector2f)
		Arrow(Vector2f, Vector2f)
		Arrow(Vector2f, Vector2f, Color&)
		Arrow(Vector2f, Vector2f, Color&, float)
		void setDirection(Vector2f)
		void setDirection(float, float)
		Vector2f getDirection()
		void setThickness(float)
		float getThickness()
		void setColor(Color&)
		Color getColor()

	cdef cppclass ConcaveShape:
		ConcaveShape()
		ConcaveShape(Shape&)
		void swap(ConcaveShape&)
		void setPointCount(unsigned int)
		unsigned int getPointCount()
		void setPoint(unsigned int, Vector2f)
		Vector2f getPoint(unsigned int)
		void setFillColor(Color&)
		void setOutlineColor(Color&)
		Color getFillColor()
		Color getOutlineColor()
		void setOutlineThickness(float)
		float getOutlineThickness()

	void swap(ConcaveShape&, ConcaveShape&)


cdef extern from "Thor/Shapes.hpp" namespace "thor::Shapes":

	ConvexShape toConvexShape(Shape&)

	ConvexShape line(Vector2f, Color&)
	ConvexShape line(Vector2f, Color&, float)

	ConvexShape roundedRect(Vector2f, float, Color&)
	ConvexShape roundedRect(Vector2f, float, Color&, float)
	ConvexShape roundedRect(Vector2f, float, Color&, float, Color&)

	ConvexShape polygon(unsigned int, float, Color&)
	ConvexShape polygon(unsigned int, float, Color&, float)
	ConvexShape polygon(unsigned int, float, Color&, float, Color&)

	ConvexShape star(unsigned int, float, float, Color&)
	ConvexShape star(unsigned int, float, float, Color&, float)
	ConvexShape star(unsigned int, float, float, Color&, float, Color&)

	ConcaveShape pie(float, float, Color&)
	ConcaveShape pie(float, float, Color&, float)
	ConcaveShape pie(float, float, Color&, float, Color&)
