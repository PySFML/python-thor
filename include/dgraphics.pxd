#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from pysfml.dsystem cimport Vector2u
from pysfml.dsystem cimport FloatRect
from pysfml.dgraphics cimport Color, Image

cdef extern from "Thor/Graphics.hpp" namespace "thor":

	cdef cppclass BigTexture:
		BigTexture()
		void swap(BigTexture&)
		bint loadFromImage(Image&)
		bint loadFromFile(char*&)
		bint loadFromMemory(char*, size_t)
		#bint loadFromStream(InputStream&)
		Vector2u getSize()

	cdef cppclass BigSprite:
		BigSprite()
		BigSprite(BigTexture&)
		void setTexture(BigTexture&)
		void setColor(Color&)
		Color getColor()
		FloatRect getLocalBounds()
		FloatRect getGlobalBounds()

	cdef cppclass ColorGradient:
		ColorGradient(Color&)
		Color getColor(float)
