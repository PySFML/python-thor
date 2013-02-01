#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport dmath

cimport pysfml.dsystem
cimport pysfml.dgraphics

from pysfml.system cimport Time

cimport distributions

cdef pysfml.dsystem.Vector2f vector2_to_vector2f(vector):
	x, y = vector
	return pysfml.dsystem.Vector2f(x, y)

cdef public class Distribution[type PyDistributionType, object PyDistributionObject]:
	cdef dmath.DistributionAPI *p_this

	# TODO: forbid functions that take arguments
	def __init__(self, object constant_or_functor):
		cdef object functor

		if '__call__' in dir(constant_or_functor):
			functor = constant_or_functor
		else:
			functor = lambda: constant_or_functor

		self.p_this = <dmath.DistributionAPI*>new dmath.DistributionObject(functor)

	def __dealloc__(self):
		del self.p_this

	def __call__(self):
		return self.p_this[0]()

cdef Distribution wrap_floatdistribution(dmath.Distribution[float] *p):
	cdef Distribution r = Distribution.__new__(Distribution)
	r.p_this = <dmath.DistributionAPI*>new dmath.DistributionFloat(p[0])
	return r

cdef Distribution wrap_vector2distribution(dmath.Distribution[pysfml.dsystem.Vector2f] *p):
	cdef Distribution r = Distribution.__new__(Distribution)
	r.p_this = <dmath.DistributionAPI*>new dmath.DistributionVector2(p[0])
	return r

cdef Distribution wrap_timedistribution(dmath.Distribution[pysfml.dsystem.Time] *p):
	cdef Distribution r = Distribution.__new__(Distribution)
	r.p_this = <dmath.DistributionAPI*>new dmath.DistributionTime(p[0])
	return r

cdef Distribution wrap_colordistribution(dmath.Distribution[pysfml.dgraphics.Color] *p):
	cdef Distribution r = Distribution.__new__(Distribution)
	r.p_this = <dmath.DistributionAPI*>new dmath.DistributionColor(p[0])
	return r

def uniform_integer(float begin, float end):
	cdef dmath.Distribution[float] *p = new dmath.Distribution[float](0)
	p[0] = dmath.distributions.uniform(begin, end)
	return wrap_floatdistribution(p)

def uniform_time(Time begin, Time end):
	cdef dmath.Distribution[pysfml.dsystem.Time] *p = new dmath.Distribution[pysfml.dsystem.Time](pysfml.dsystem.seconds(1))
	p[0] = dmath.distributions.uniform(<pysfml.dsystem.Time>begin.p_this[0], <pysfml.dsystem.Time>end.p_this[0])
	return wrap_timedistribution(p)

def rect(center, half_size):
	cdef dmath.Distribution[pysfml.dsystem.Vector2f] *p = new dmath.Distribution[pysfml.dsystem.Vector2f](pysfml.dsystem.Vector2f())
	p[0] = dmath.distributions.rect(vector2_to_vector2f(center), vector2_to_vector2f(half_size))
	return wrap_vector2distribution(p)

def circle(center, float radius):
	cdef dmath.Distribution[pysfml.dsystem.Vector2f] *p = new dmath.Distribution[pysfml.dsystem.Vector2f](pysfml.dsystem.Vector2f())
	p[0] = dmath.distributions.circle(vector2_to_vector2f(center), radius)
	return wrap_vector2distribution(p)

def deflect(direction, float max_rotation):
	cdef dmath.Distribution[pysfml.dsystem.Vector2f] *p = new dmath.Distribution[pysfml.dsystem.Vector2f](pysfml.dsystem.Vector2f())
	p[0] = dmath.distributions.deflect(vector2_to_vector2f(direction), max_rotation)
	return wrap_vector2distribution(p)

def random(float begin, float end):
	return dmath.random(begin, end)

def random_dev(float middle, float deviation):
	return dmath.randomDev(middle, deviation)

def set_random_seed(unsigned long seed):
	dmath.setRandomSeed(seed)


cdef class Edge:
	cdef dmath.Edge[unsigned long] *p_this
	cdef object                     c0, c1
	cdef unsigned long              p_c0, p_c1

	def __init__(self, object corner0, object corner1):
		self.c0, self.c1 = corner0, corner1

		self.p_c0 = <unsigned long><void*>self.c0
		self.p_c1 = <unsigned long><void*>self.c1

		self.p_this = new dmath.Edge[unsigned long](self.p_c0, self.p_c1)

	def __dealloc__(self):
		del self.p_this

	def __getitem__(self, unsigned int key):
		return <object><void*>self.p_this[0][key]

cdef class Triangle:
	cdef dmath.Triangle[unsigned long] *p_this
	cdef object                         c0, c1, c2
	cdef unsigned long                  p_c0, p_c1, p_c2

	def __init__(self, object corner0, object corner1, object corner2):
		self.c0, self.c1, self.c2 = corner0, corner1, corner2

		self.p_c0 = <unsigned long><void*>self.c0
		self.p_c1 = <unsigned long><void*>self.c1
		self.p_c2 = <unsigned long><void*>self.c2

		self.p_this = new dmath.Triangle[unsigned long](self.p_c0, self.p_c1, self.p_c2)

	def __dealloc__(self):
		del self.p_this

	def __getitem__(self, unsigned int key):
		return <object><void*>self.p_this[0][key]


cdef api object create_triangle(object c1, object c2, object c3):
	return Triangle(c1, c2, c3)

cdef api object wrap_triangle(dmath.Triangle[unsigned long] *p):
	cdef Triangle r = Triangle.__new__(Triangle)

	r.c0 = <object><void*>p[0][0]
	r.c1 = <object><void*>p[0][1]
	r.c2 = <object><void*>p[0][2]

	r.p_c0 = <unsigned long><void*>r.c0
	r.p_c1 = <unsigned long><void*>r.c1
	r.p_c2 = <unsigned long><void*>r.c2

	r.p_this = p

	return r


def triangulate(vertices):
	return dmath.triangulate(vertices)

#def triangulate_constrained():
	#raise NotImplemented

#def triangulate_polygon():
	#raise NotImplemented

#def to_degree():
	#raise NotImplemented

#def to_radian():
	#raise NotImplemented

#def swap():
	#raise NotImplemented

## PI


