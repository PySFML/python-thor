# PyThor - Python bindings for Thor
# Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PyThor project and is available under the zlib
# license.

"""
    Extensions for sf.Shape, like concave shapes or predefined figures.
"""

# todo list
# ---------
# * consider using a submodule to put what is in th::Shapes namespace
# * rename header dshapes.pxd when there's no longer conflicting name

cimport sfml as sf
cimport thor as th

from pysfml.system cimport import_sfml__system
from pysfml.system cimport wrap_vector2f, to_vector2f
from pysfml.graphics cimport import_sfml__graphics
from pysfml.graphics cimport wrap_floatrect
from pysfml.graphics cimport Color, wrap_color
from pysfml.graphics cimport TransformableDrawable
from pysfml.graphics cimport Shape, wrap_convexshape

__all__ = ['Arrow', 'ConcaveShape', 'Shapes']

import_sfml__system()
import_sfml__graphics()

cdef public class Arrow(TransformableDrawable)[type PyArrowType, object PyArrowObject]:
    LINE = th.arrow.Line
    FORWARD = th.arrow.Forward

    cdef th.Arrow *p_this

    def __init__(self, position=(0, 0), direction=(0, 0), Color color=Color.WHITE, float thickness=3.0):
        self.p_this          = new th.Arrow(to_vector2f(position), to_vector2f(direction), color.p_this[0], thickness)
        self.p_drawable      = <sf.Drawable*>self.p_this
        self.p_transformable = <sf.Transformable*>self.p_this

    def __dealloc__(self):
        self.p_drawable = NULL
        self.p_transformable = NULL
        if self.p_this != NULL:
            del self.p_this

    @classmethod
    def set_zero_vector_tolerance(cls, float tolerance):
        th.Arrow.setZeroVectorTolerance(tolerance)

    @classmethod
    def get_zero_vector_tolerance(cls):
        return th.Arrow.getZeroVectorTolerance()

    property direction:
        def __get__(self):
            cdef sf.Vector2f p = self.p_this.getDirection()
            return wrap_vector2f(p)

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
            self.p_this          = new th.ConcaveShape()
            self.p_transformable = <sf.Transformable*>self.p_this
            self.p_drawable      = <sf.Drawable*>self.p_this

    def __dealloc__(self):
        self.p_drawable      = NULL
        self.p_transformable = NULL
        if self.p_this != NULL:
            del self.p_this

    @classmethod
    def from_shape(cls, Shape shape):
        cdef th.ConcaveShape *p = new th.ConcaveShape(shape.p_shape[0])
        return wrap_concaveshape(p)

    property point_count:
        def __get__(self):
            return self.p_this.getPointCount()

        def __set__(self, size_t count):
            self.p_this.setPointCount(count)

    def get_point(self, size_t index):
        cdef sf.Vector2f p = self.p_this.getPoint(index)
        return wrap_vector2f(p)

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
            return wrap_floatrect(&p)

    property global_bounds:
        def __get__(self):
            cdef sf.FloatRect p = self.p_this.getGlobalBounds()
            return wrap_floatrect(&p)

cdef api object wrap_concaveshape(th.ConcaveShape *p):
    cdef ConcaveShape r = ConcaveShape.__new__(ConcaveShape)
    r.p_this = p
    r.p_transformable = <sf.Transformable*>p
    r.p_drawable = <sf.Drawable*>p
    return r

class Shapes:
    @classmethod
    def to_convexshape(cls, Shape shape):
        cdef sf.ConvexShape *p = new sf.ConvexShape()
        p[0] = th.dshapes.toConvexShape(shape.p_shape[0])
        return wrap_convexshape(p)

    @classmethod
    def line(cls, direction, Color color, float thickness=1.0):
        cdef sf.ConvexShape *p = new sf.ConvexShape()
        p[0] = th.dshapes.line(to_vector2f(direction), color.p_this[0], thickness)
        return wrap_convexshape(p)

    @classmethod
    def rounded_rect(cls, size, float corner_radius, Color fill_color, float outline_thickness=0.0, Color outline_color=Color()):
        cdef sf.ConvexShape *p = new sf.ConvexShape()
        p[0] = th.dshapes.roundedRect(to_vector2f(size), corner_radius, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
        return wrap_convexshape(p)

    @classmethod
    def polygon(cls, size_t nb_points, float radius, Color fill_color, float outline_thickness=0.0, Color outline_color=Color()):
        cdef sf.ConvexShape *p = new sf.ConvexShape()
        p[0] = th.dshapes.polygon(nb_points, radius, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
        return wrap_convexshape(p)

    @classmethod
    def star(cls, size_t nb_start_points, float inner_radius, float outer_radius, Color fill_color, float outline_thickness=0.0, Color outline_color=Color()):
        cdef sf.ConvexShape *p = new sf.ConvexShape()
        p[0] = th.dshapes.star(nb_start_points, inner_radius, outer_radius, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
        return wrap_convexshape(p)
