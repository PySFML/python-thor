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
