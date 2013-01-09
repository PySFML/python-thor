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
from pysfml.dgraphics cimport Color

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
