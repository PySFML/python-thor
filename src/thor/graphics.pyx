#-------------------------------------------------------------------------------
# PyThor - Python bindings for Thor
# Copyright (c) 2013-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is provided 'as-is', without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from the
# use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software in a
#    product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
#
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
#
# 3. This notice may not be removed or altered from any source distribution.
#-------------------------------------------------------------------------------

cimport libcpp.sfml as sf
cimport libcpp.thor as th

from pysfml.system cimport Vector2
from pysfml.graphics cimport Rectangle
from pysfml.graphics cimport Color, wrap_color
from pysfml.graphics cimport Image
from pysfml.graphics cimport TransformableDrawable
from pysfml.graphics cimport RenderTarget, RenderStates
from pysfml.graphics cimport floatrect_to_rectangle


cdef class BigTexture:
	cdef th.BigTexture *p_this
	cdef bint                  delete_this

	def __cinit__(self):
		self.p_this = new th.BigTexture()
		self.delete_this = True

	def __dealloc__(self):
		if self.delete_this: del self.p_this

	@classmethod
	def from_file(cls, filename):
		cdef th.BigTexture *p = new th.BigTexture()
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
		cdef th.BigTexture *p = new th.BigTexture()

		if p.loadFromMemory(<char*>data, len(data)):
			return wrap_bigtexture(p)

		del p
		# TODO: print the right message error
		raise IOError("Couldn't load sf.BigTexture")
		# raise IOError(pop_error_message())

	@classmethod
	def from_image(cls, Image image):
		cdef th.BigTexture *p = new th.BigTexture()

		if p.loadFromImage(image.p_this[0]):
			return wrap_bigtexture(p)

		del p
		# TODO: print the right message error
		raise IOError("Couldn't load sf.BigTexture")
		# raise IOError(pop_error_message())

	property size:
		def __get__(self):
			return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)

	def swap(self, BigTexture other):
		self.p_this.swap(other.p_this[0])

cdef BigTexture wrap_bigtexture(th.BigTexture *p):
	cdef BigTexture r = BigTexture.__new__(BigTexture)
	r.p_this = p
	return r


cdef class BigSprite(TransformableDrawable):
	cdef th.BigSprite *p_this
	cdef BigTexture           m_texture

	def __cinit__(self, BigTexture texture=None):
		if not texture:
			self.p_this = new th.BigSprite()
		else:
			self.p_this = new th.BigSprite(texture.p_this[0])
			m_texture = texture

		self.p_drawable = <sf.Drawable*>self.p_this
		self.p_transformable = <sf.Transformable*>self.p_this

	def __dealloc__(self):
		del self.p_this

	def draw(self, RenderTarget target, RenderStates states):
		target.p_rendertarget.draw((<sf.Drawable*>self.p_this)[0])

	property texture:
		def __get__(self):
			return NotImplemented

		def __set__(self, BigTexture texture):
			self.p_this.setTexture(texture.p_this[0])
			self.m_texture = texture

	property color:
		def __get__(self):
			cdef th.Color* p = new th.Color()
			p[0] = self.p_this.getColor()
			return wrap_color(p)

		def __set__(self, Color color):
			self.p_this.setColor(color.p_this[0])

	property local_bounds:
		def __get__(self):
			cdef sf.FloatRect p = self.p_this.getLocalBounds()
			return floatrect_to_rectangle(&p)

	property global_bounds:
		def __get__(self):
			cdef sf.FloatRect p = self.p_this.getGlobalBounds()
			return floatrect_to_rectangle(&p)

cdef public class ColorGradient[type PyColorGradientType, object PyColorGradientObject]:
	cdef th.ColorGradient *p_this

	def __init__(self, Color color):
		self.p_this = new th.ColorGradient(color.p_this[0])

	def __dealloc__(self):
		del self.p_this

	def get_color(self, float interpolation):
		cdef sf.Color* p = new sf.Color()
		p[0] = self.p_this.getColor(interpolation)
		return wrap_color(p)

cdef api object wrap_colorgradient(th.ColorGradient *p):
	cdef ColorGradient r = ColorGradient.__new__(ColorGradient)
	r.p_this = p
	return r

def blend_colors(Color first_color, Color second_color, float interpolation):
	cdef th.Color* p = new th.Color()
	p[0] = th.blendColors(first_color.p_this[0], second_color.p_this[0], interpolation)
	return wrap_color(p)

def create_gradient(object mylist):
	return th.createGradientFromList(mylist)
