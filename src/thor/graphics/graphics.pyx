# PyThor - Python bindings for Thor
# Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PyThor project and is available under the zlib
# license.

"""
    Miscellaneous graphics-related functionality, such as specialized
    sprites or color helpers.
"""

# todo list
# ---------
# * do something when sampling color position is out of range 0 ... 1.f (raise exception?) (in both ColorGradient.__setitem__() method and sample_color() function)
# * should we implement set_color or set_alpha ? need design input before implemeting them
# * in BigTexture.from_*() methods, instead of raising IOError with custom error message, use popLastErrorMessage()

cimport sfml as sf
cimport thor as th

from pysfml.system cimport Vector2
from pysfml.graphics cimport Color, wrap_color
from pysfml.graphics cimport Image
from pysfml.graphics cimport TransformableDrawable
from pysfml.graphics cimport RenderTarget, RenderStates
from pysfml.graphics cimport import_sfml__graphics
from pysfml.graphics cimport wrap_floatrect

__all__ = ['BigTexture', 'BigSprite', 'ColorGradient', 'blend_colors']

import_sfml__graphics()

cdef public class BigTexture[type PyBigTextureType, object PyBigTextureObject]:
    cdef th.BigTexture *p_this

    cdef object __weakref__

    def __init__(self):
        raise UserWarning("Use a specific constructor")

    def __dealloc__(self):
        del self.p_this

    @classmethod
    def from_file(cls, filename):
        cdef th.BigTexture *p = new th.BigTexture()
        cdef char* encoded_filename

        encoded_filename_temporary = filename.encode('UTF-8')
        encoded_filename = encoded_filename_temporary

        if p.loadFromFile(encoded_filename):
            return wrap_bigtexture(p)

        del p
        raise IOError("Failed to load the image")

    @classmethod
    def from_memory(cls, bytes data):
        cdef th.BigTexture *p = new th.BigTexture()

        if p.loadFromMemory(<char*>data, len(data)):
            return wrap_bigtexture(p)

        del p
        raise IOError("Failed to load the image")

    @classmethod
    def from_image(cls, Image image):
       cdef th.BigTexture *p = new th.BigTexture()

       if p.loadFromImage(image.p_this[0]):
           return wrap_bigtexture(p)

       del p
       raise IOError("Failed to load the image")

    property size:
        def __get__(self):
            return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)

    property smooth:
        def __get__(self):
            return self.p_this.isSmooth()

        def __set__(self, bint smooth):
            self.p_this.setSmooth(smooth)

cdef api BigTexture wrap_bigtexture(th.BigTexture *p):
    cdef BigTexture r = BigTexture.__new__(BigTexture)
    r.p_this = p
    return r

cdef class BigSprite(TransformableDrawable):
    cdef th.BigSprite *p_this
    cdef BigTexture    m_texture

    def __init__(self, BigTexture texture=None):
        if self.p_this == NULL:
            if not texture:
                self.p_this = new th.BigSprite()
            else:
                self.p_this = new th.BigSprite(texture.p_this[0])
                self.m_texture = texture

            self.p_drawable = <sf.Drawable*>self.p_this
            self.p_transformable = <sf.Transformable*>self.p_this

    def __dealloc__(self):
        self.p_drawable = NULL
        self.p_transformable = NULL
        if self.p_this != NULL:
            del self.p_this

    def draw(self, RenderTarget target, RenderStates states):
        target.p_rendertarget.draw((<sf.Drawable*>self.p_this)[0])

    property texture:
        def __get__(self):
            return self.m_texture

        def __set__(self, BigTexture texture):
            self.p_this.setTexture(texture.p_this[0])
            self.m_texture = texture

    property color:
        def __get__(self):
            cdef sf.Color* p = new sf.Color()
            p[0] = self.p_this.getColor()
            return wrap_color(p)

        def __set__(self, Color color):
            self.p_this.setColor(color.p_this[0])

    property local_bounds:
        def __get__(self):
            cdef sf.FloatRect* p = new sf.FloatRect()
            p[0] = self.p_this.getLocalBounds()
            return wrap_floatrect(p)

    property global_bounds:
        def __get__(self):
            cdef sf.FloatRect* p = new sf.FloatRect()
            p[0] = self.p_this.getGlobalBounds()
            return wrap_floatrect(p)

cdef public class ColorGradient[type PyColorGradientType, object PyColorGradientObject]:
    cdef th.ColorGradient *p_this

    def __cinit__(self):
       self.p_this = new th.ColorGradient()

    def __dealloc__(self):
       del self.p_this

    def __setitem__(self, float position, Color color):
        self.p_this[0][position] = color.p_this[0]

    def sample_color(self, float position):
        cdef sf.Color* p = new sf.Color()
        p[0] = self.p_this.sampleColor(position)
        return wrap_color(p)

def blend_colors(Color first_color, Color second_color, float interpolation):
   cdef sf.Color* p = new sf.Color()
   p[0] = th.blendColors(first_color.p_this[0], second_color.p_this[0], interpolation)
   return wrap_color(p)
