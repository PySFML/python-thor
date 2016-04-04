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

cimport sfml as sf
cimport thor as th

from pysfml.system cimport Vector2
from pysfml.graphics cimport Color, wrap_color
from pysfml.graphics cimport Image
from pysfml.graphics cimport TransformableDrawable
from pysfml.graphics cimport RenderTarget, RenderStates
from pysfml.graphics cimport floatrect_to_rectangle
from pythor.graphics cimport wrap_bigtexture

__all__ = ['BigTexture', 'BigSprite', 'ColorGradient', 'blend_colors']

cdef public class BigTexture[type PyBigTextureType, object PyBigTextureObject]:
    cdef th.BigTexture *p_this

    def __init__(self):
        self.p_this = new th.BigTexture()

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

        if p.loadFromMemory(<void*>data, len(data)):
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


cdef class BigSprite(TransformableDrawable):
    cdef th.BigSprite *p_this
    cdef BigTexture m_texture

    def __init__(self, BigTexture texture=None):
        if self.p_this == NULL:
            if not texture:
                self.p_this = new th.BigSprite()
            else:
                self.p_this = new th.BigSprite(texture.p_this[0])
                m_texture = texture

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
            return NotImplemented

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
            cdef sf.FloatRect p = self.p_this.getLocalBounds()
            return floatrect_to_rectangle(&p)

    property global_bounds:
        def __get__(self):
            cdef sf.FloatRect p = self.p_this.getGlobalBounds()
            return floatrect_to_rectangle(&p)


cdef public class ColorGradient[type PyColorGradientType, object PyColorGradientObject]:
    cdef th.ColorGradient *p_this

    def __init__(self):
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
