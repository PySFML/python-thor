#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport libcpp.sfml as sf
cimport libcpp.thor as th

from pysfml.system   cimport Vector2, to_vector2f
from pysfml.graphics cimport Color, wrap_color
from pysfml.graphics cimport Drawable, TransformableDrawable
from pysfml.graphics cimport Shape, ConvexShape, wrap_convexshape
from pysfml.graphics cimport RenderTarget, RenderStates


cdef class Arrow(TransformableDrawable):
	cdef th.Arrow *p_this

	def __cinit__(self, position=(0, 0), direction=(0, 0), Color color=Color.WHITE, float thickness=3.0):
		cdef sf.Vector2f cposition = to_vector2f(position)
		cdef sf.Vector2f cdirection = to_vector2f(position)

		self.p_this = new th.Arrow(cposition, cdirection, color.p_this[0], thickness)

		self.p_drawable = <sf.Drawable*>self.p_this
		self.p_transformable = <sf.Transformable*>self.p_this

	def __dealloc__(self):
		del self.p_this

	def draw(self, RenderTarget target, RenderStates states):
		target.p_rendertarget.draw((<sf.Drawable*>self.p_this)[0])

	@classmethod
	def get_zero_vector_tolerance(cls):
		return th.listener.getZeroVectorTolerance()

	@classmethod
	def set_zero_vector_tolerance(cls, float tolerance):
		th.listener.setZeroVectorTolerance(tolerance)

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


cdef class ConcaveShape(TransformableDrawable):
	cdef th.ConcaveShape *p_this

	def __init__(self, Shape shape=None):
		if not shape:
			self.p_this = new th.ConcaveShape()
		else:
			self.p_this = new th.ConcaveShape(shape.p_shape[0])

		self.p_drawable = <sf.Drawable*>self.p_this
		self.p_transformable = <sf.Transformable*>self.p_this

	def __dealloc__(self):
		del self.p_this

	def draw(self, RenderTarget target, RenderStates states):
		target.p_rendertarget.draw((<sf.Drawable*>self.p_this)[0])

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

	property point_count:
		def __get__(self):
			return self.p_this.getPointCount()

		def __set__(self, unsigned int count):
			self.p_this.setPointCount(count)

	def get_point(self, unsigned int index):
		return Vector2(self.p_this.getPoint(index).x, self.p_this.getPoint(index).y)

	def set_point(self, unsigned int index, point):
		self.p_this.setPoint(index, to_vector2f(point))

	def swap(self, ConcaveShape other):
		self.p_this.swap(other.p_this[0])

cdef ConcaveShape wrap_concaveshape(th.ConcaveShape *p):
	cdef ConcaveShape r = ConcaveShape.__new__(ConcaveShape)
	r.p_this = p
	r.p_drawable = <sf.Drawable*>p
	r.p_transformable = <sf.Transformable*>p
	return r

def to_convexshape(Shape shape):
	cdef sf.ConvexShape *p = new sf.ConvexShape()
	p[0] = th.toConvexShape(shape.p_shape[0])
	return wrap_convexshape(p)

def line(direction, Color color, float thickness=1.0):
	cdef sf.ConvexShape *p = new sf.ConvexShape()
	p[0] = th.line(to_vector2f(direction), color.p_this[0], thickness)
	return wrap_convexshape(p)

def rounded_rectangle(size, float corner_radius, Color fill_color, float outline_thickness=0.0, Color outline_color=None):
	cdef sf.ConvexShape *p = new sf.ConvexShape()
	if not outline_color:
		p[0] = th.roundedRect(to_vector2f(size), corner_radius, fill_color.p_this[0], outline_thickness)
	else:
		p[0] = th.roundedRect(to_vector2f(size), corner_radius, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
	return wrap_convexshape(p)

def polygon(unsigned int nb_points, float radius, Color fill_color, float outline_thickness=0.0, Color outline_color=None):
	cdef sf.ConvexShape *p = new sf.ConvexShape()
	if not outline_color:
		p[0] = th.polygon(nb_points, radius, fill_color.p_this[0], outline_thickness)
	else:
		p[0] = th.polygon(nb_points, radius, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
	return wrap_convexshape(p)

def star(unsigned int nb_start_points, float inner_radius, float outer_radius, Color fill_color, float outline_thickness=0.0, Color outline_color=None):
	cdef sf.ConvexShape *p = new sf.ConvexShape()
	if not outline_color:
		p[0] = th.star(nb_start_points, inner_radius, outer_radius, fill_color.p_this[0], outline_thickness)
	else:
		p[0] = th.star(nb_start_points, inner_radius, outer_radius, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
	return wrap_convexshape(p)

def pie(float radius, float filled_angle, Color fill_color, float outline_thickness=0.0, Color outline_color=None):
	cdef th.ConcaveShape *p = new th.ConcaveShape()
	if not outline_color:
		p[0] = th.pie(radius, filled_angle, fill_color.p_this[0], outline_thickness)
	else:
		p[0] = th.pie(radius, filled_angle, fill_color.p_this[0], outline_thickness, outline_color.p_this[0])
	return wrap_concaveshape(p)
