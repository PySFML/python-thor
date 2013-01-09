#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from pysfml cimport dsystem, dgraphics
cimport dshapes

from pysfml.system   cimport Vector2
from pysfml.graphics cimport Color, wrap_color
from pysfml.graphics cimport Drawable, TransformableDrawable
from pysfml.graphics cimport RenderTarget, RenderStates

cdef dsystem.Vector2f vector2_to_vector2f(vector):
	x, y = vector
	return dsystem.Vector2f(x, y)

cdef class Arrow(TransformableDrawable):
	cdef dshapes.Arrow *p_this

	# TODO: improve constructor
	def __cinit__(self, position, direction, Color color, float thickness):
		cdef dsystem.Vector2f cposition = vector2_to_vector2f(position)
		cdef dsystem.Vector2f cdirection = vector2_to_vector2f(position)
		self.p_this = new dshapes.Arrow(cposition, cdirection, color.p_this[0], thickness)

		self.p_drawable = <dgraphics.Drawable*>self.p_this
		self.p_transformable = <dgraphics.Transformable*>self.p_this

	def __dealloc__(self):
		del self.p_this
		
	def draw(self, RenderTarget target, RenderStates states):
		target.p_rendertarget.draw((<dgraphics.Drawable*>self.p_this)[0])
		
	property direction:
		def __get__(self):
			cdef dsystem.Vector2f p = self.p_this.getDirection()
			return Vector2(p.x, p.y)
			
		def __set__(self, direction):
			self.p_this.setDirection(vector2_to_vector2f(direction))
			
	property thickness:
		def __get__(self):
			return self.p_this.getThickness()
			
		def __set__(self, float thickness):
			self.p_this.setThickness(thickness)
			
	property color:
		def __get__(self):
			cdef dgraphics.Color* p = new dgraphics.Color()
			p[0] = self.p_this.getColor()
			return wrap_color(p)
			
		def __set__(self, Color color):
			self.p_this.setColor(color.p_this[0])

