#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


#cimport pysfml.dsystem 
cimport pysfml.dsystem
cimport pysfml.dgraphics 
cimport dgraphics

from pysfml.system cimport Vector2
from pysfml.graphics cimport Rectangle
from pysfml.graphics cimport Color, wrap_color
from pysfml.graphics cimport Image
from pysfml.graphics cimport TransformableDrawable
from pysfml.graphics cimport RenderTarget, RenderStates

cdef Rectangle floatrect_to_rectangle(pysfml.dsystem.FloatRect* floatrect):
	return Rectangle((floatrect.left, floatrect.top), (floatrect.width, floatrect.height))


cdef class BigTexture:
	cdef dgraphics.BigTexture *p_this
	cdef bint                  delete_this
	
	def __cinit__(self):
		self.p_this = new dgraphics.BigTexture()
		self.delete_this = True

	def __dealloc__(self):
		if self.delete_this: del self.p_this

	@classmethod
	def from_file(cls, filename):
		cdef dgraphics.BigTexture *p = new dgraphics.BigTexture()
		cdef char* encoded_filename
		
		encoded_filename_temporary = filename.encode('UTF-8')	
		encoded_filename = encoded_filename_temporary
		
		if p.loadFromFile(encoded_filename): 
			return wrap_bigtexture(p)

		del p
		# TODO: print the right message error
		raise IOError("Couldn't load sf.BigTexture")
		# raise IOError(pop_error_message())

	@classmethod
	def from_memory(cls, bytes data):
		cdef dgraphics.BigTexture *p = new dgraphics.BigTexture()
		
		if p.loadFromMemory(<char*>data, len(data)): 
			return wrap_bigtexture(p)

		del p
		# TODO: print the right message error
		raise IOError("Couldn't load sf.BigTexture")
		# raise IOError(pop_error_message())

	@classmethod
	def from_image(cls, Image image):
		cdef dgraphics.BigTexture *p = new dgraphics.BigTexture()
		
		if p.loadFromImage(image.p_this[0]):
			return wrap_bigtexture(p)
		
		del p
		# TODO: print the right message error
		raise IOError("Couldn't load sf.BigTexture")
		# raise IOError(pop_error_message())

	property size:
		def __get__(self):
			return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)

cdef BigTexture wrap_bigtexture(dgraphics.BigTexture *p):
	cdef BigTexture r = BigTexture.__new__(BigTexture)
	r.p_this = p
	return r


cdef class BigSprite(TransformableDrawable):
	cdef dgraphics.BigSprite *p_this
	cdef BigTexture           m_texture
	
	# TODO: allow to construct an empty BigSprite
	def __cinit__(self, BigTexture texture):
		self.p_this = new dgraphics.BigSprite(texture.p_this[0])
		self.p_drawable = <pysfml.dgraphics.Drawable*>self.p_this
		self.p_transformable = <pysfml.dgraphics.Transformable*>self.p_this

		m_texture = texture
		
	def __dealloc__(self):
		del self.p_this
		
	def draw(self, RenderTarget target, RenderStates states):
		target.p_rendertarget.draw((<pysfml.dgraphics.Drawable*>self.p_this)[0])
		
	property texture:
		def __get__(self):
			return NotImplemented

		def __set__(self, BigTexture texture):
			self.p_this.setTexture(texture.p_this[0])
			self.m_texture = texture
			
	property color:
		def __get__(self):
			cdef dgraphics.Color* p = new dgraphics.Color()
			p[0] = self.p_this.getColor()
			return wrap_color(p)
			
		def __set__(self, Color color):
			self.p_this.setColor(color.p_this[0])

	property local_bounds:
		def __get__(self):
			cdef pysfml.dsystem.FloatRect p = self.p_this.getLocalBounds()
			return floatrect_to_rectangle(&p)
		
	property global_bounds:
		def __get__(self):
			cdef pysfml.dsystem.FloatRect p = self.p_this.getGlobalBounds()
			return floatrect_to_rectangle(&p)

cdef public class ColorGradient[type PyColorGradientType, object PyColorGradientObject]:
	cdef dgraphics.ColorGradient *p_this

	def __init__(self, Color color):
		self.p_this = new dgraphics.ColorGradient(color.p_this[0])

	def __dealloc__(self):
		del self.p_this

	def get_color(self, float interpolation):
		cdef pysfml.dgraphics.Color* p = new pysfml.dgraphics.Color()
		p[0] = self.p_this.getColor(interpolation)
		return wrap_color(p)

cdef api object wrap_colorgradient(dgraphics.ColorGradient *p):
	cdef ColorGradient r = ColorGradient.__new__(ColorGradient)
	r.p_this = p
	return r
