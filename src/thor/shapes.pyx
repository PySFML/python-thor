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

from pysfml.system cimport Vector2, to_vector2f
from pysfml.graphics cimport Color, wrap_color
from pysfml.graphics cimport Drawable, TransformableDrawable
from pysfml.graphics cimport Shape, ConvexShape, wrap_convexshape
from pysfml.graphics cimport RenderTarget, RenderStates
from pysfml.graphics cimport floatrect_to_rectangle

__all__ = ['Arrow', 'ConcaveShape', 'to_convexshape', 'line', 'rounded_rectangle',
    'polygon', 'star']

cdef public class Arrow(TransformableDrawable)[type PyArrowType, object PyArrowObject]:
    LINE = th.arrow.Line
    FORWARD = th.arrow.Forward

    cdef th.Arrow *p_this

    def __init__(self, position=(0, 0), direction=(0, 0), Color color=Color.WHITE, float thickness=3.0):
        self.p_this = new th.Arrow(to_vector2f(position), to_vector2f(direction), color.p_this[0], thickness)
        self.p_drawable = <sf.Drawable*>self.p_this
        self.p_transformable = <sf.Transformable*>self.p_this

    def __dealloc__(self):
        self.p_drawable = NULL
        self.p_transformable = NULL
        if self.p_this != NULL:
            del self.p_this

    @classmethod
    def set_zero_vector_tolerance(cls, float tolerance):
        th.arrow.setZeroVectorTolerance(tolerance)

    @classmethod
    def get_zero_vector_tolerance(cls):
        return th.arrow.getZeroVectorTolerance()

    property direction:
        def __get__(self):
            cdef sf.Vector2f p = self.p_this.getDirection()
            return Vector2(p.x, p.y)

        def __set__(self, direction):
            self.p_this.setDirection(to_vector2f(direction))

    property thickness:
        def __get__(self):
            return self.p_this.getThickness()

        def __set__(self, float thickness):
            self.p_this.setThickness(thickness)

    property color:
        def __get__(self):
            cdef sf.Color* p = new sf.Color()
            p[0] = self.p_this.getColor()
            return wrap_color(p)

        def __set__(self, Color color):
            self.p_this.setColor(color.p_this[0])

    property style:
        def __get__(self):
            return self.p_this.getStyle()

        def __set__(self, th.arrow.Style style):
            self.p_this.setStyle(style)

cdef public class ConcaveShape(TransformableDrawable)[type PyConcaveShapeType, object PyConcaveShapeObject]:
    cdef th.ConcaveShape *p_this

    def __init__(self):
        if self.p_this == NULL:
            self.p_this = new th.ConcaveShape()
            self.p_transformable = <sf.Transformable*>self.p_this
            self.p_drawable = <sf.Drawable*>self.p_this

    def __dealloc__(self):
        self.p_drawable = NULL
        self.p_transformable = NULL
        if self.p_this != NULL:
            del self.p_this

    property point_count:
        def __get__(self):
            return self.p_this.getPointCount()

        def __set__(self, size_t count):
            self.p_this.setPointCount(count)

    def get_point(self, size_t index):
        return Vector2(self.p_this.getPoint(index).x, self.p_this.getPoint(index).y)

    def set_point(self, size_t index, point):
        self.p_this.setPoint(index, to_vector2f(point))

    property fill_color:
        def __get__(self):
            cdef sf.Color* p = new sf.Color()
            p[0] = self.p_this.getFillColor()
            return wrap_color(p)

        def __set__(self, Color color):
            self.p_this.setFillColor(color.p_this[0])

    property outline_color:
        def __get__(self):
            cdef sf.Color* p = new sf.Color()
            p[0] = self.p_this.getOutlineColor()
            return wrap_color(p)

        def __set__(self, Color color):
            self.p_this.setOutlineColor(color.p_this[0])

    property outline_thickness:
        def __get__(self):
            return self.p_this.getOutlineThickness()

        def __set__(self, float thickness):
            self.p_this.setOutlineThickness(thickness)

    property local_bounds:
        def __get__(self):
            cdef sf.FloatRect p = self.p_this.getLocalBounds()
            return floatrect_to_rectangle(&p)

    property global_bounds:
        def __get__(self):
            cdef sf.FloatRect p = self.p_this.getGlobalBounds()
            return floatrect_to_rectangle(&p)

def to_convexshape(Shape shape):
    cdef sf.ConvexShape *p = new sf.ConvexShape()
    p[0] = th.dshapes.toConvexShape(shape.p_shape[0])
    return wrap_convexshape(p)

def line(direction, Color color, float thickness=1.0):
    cdef sf.ConvexShape *p = new sf.ConvexShape()
    p[0] = th.dshapes.line(to_vector2f(direction), color.p_this[0], thickness)
    return wrap_convexshape(p)

def rounded_rectangle(size, float corner_radius, Color fill_color, float outline_thickness=0.0, Color outline_color=Color()):
    cdef sf.ConvexShape *p = new sf.ConvexShape()
    p[0] = th.dshapes.roundedRect(to_vector2f(size), corner_radius, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
    return wrap_convexshape(p)

def polygon(size_t nb_points, float radius, Color fill_color, float outline_thickness=0.0, Color outline_color=Color()):
    cdef sf.ConvexShape *p = new sf.ConvexShape()
    p[0] = th.dshapes.polygon(nb_points, radius, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
    return wrap_convexshape(p)

def star(size_t nb_start_points, float inner_radius, float outer_radius, Color fill_color, float outline_thickness=0.0, Color outline_color=Color()):
    cdef sf.ConvexShape *p = new sf.ConvexShape()
    p[0] = th.dshapes.star(nb_start_points, inner_radius, outer_radius, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
    return wrap_convexshape(p)
