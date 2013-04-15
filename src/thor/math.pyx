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

from pysfml.system cimport Time
from pysfml.system cimport to_vector2f

cdef public class Distribution[type PyDistributionType, object PyDistributionObject]:
	cdef th.DistributionAPI *p_this

	# TODO: forbid functions that take arguments
	def __init__(self, object constant_or_functor):
		cdef object functor

		if '__call__' in dir(constant_or_functor):
			functor = constant_or_functor
		else:
			functor = lambda: constant_or_functor

		self.p_this = <th.DistributionAPI*>new th.DistributionObject(functor)

	def __dealloc__(self):
		del self.p_this

	def __call__(self):
		return self.p_this[0]()

cdef Distribution wrap_floatdistribution(th.Distribution[float] *p):
	cdef Distribution r = Distribution.__new__(Distribution)
	r.p_this = <th.DistributionAPI*>new th.DistributionFloat(p[0])
	return r

cdef Distribution wrap_vector2distribution(th.Distribution[sf.Vector2f] *p):
	cdef Distribution r = Distribution.__new__(Distribution)
	r.p_this = <th.DistributionAPI*>new th.DistributionVector2(p[0])
	return r

cdef Distribution wrap_timedistribution(th.Distribution[sf.Time] *p):
	cdef Distribution r = Distribution.__new__(Distribution)
	r.p_this = <th.DistributionAPI*>new th.DistributionTime(p[0])
	return r

cdef Distribution wrap_colordistribution(th.Distribution[sf.Color] *p):
	cdef Distribution r = Distribution.__new__(Distribution)
	r.p_this = <th.DistributionAPI*>new th.DistributionColor(p[0])
	return r

def uniform_integer(float begin, float end):
	cdef th.Distribution[float] *p = new th.Distribution[float](0)
	p[0] = th.distributions.uniform(begin, end)
	return wrap_floatdistribution(p)

def uniform_time(Time begin, Time end):
	cdef th.Distribution[sf.Time] *p = new th.Distribution[sf.Time](sf.seconds(1))
	p[0] = th.distributions.uniform(<sf.Time>begin.p_this[0], <sf.Time>end.p_this[0])
	return wrap_timedistribution(p)

def rect(center, half_size):
	cdef th.Distribution[sf.Vector2f] *p = new th.Distribution[sf.Vector2f](sf.Vector2f())
	p[0] = th.distributions.rect(to_vector2f(center), to_vector2f(half_size))
	return wrap_vector2distribution(p)

def circle(center, float radius):
	cdef th.Distribution[sf.Vector2f] *p = new th.Distribution[sf.Vector2f](sf.Vector2f())
	p[0] = th.distributions.circle(to_vector2f(center), radius)
	return wrap_vector2distribution(p)

def deflect(direction, float max_rotation):
	cdef th.Distribution[sf.Vector2f] *p = new th.Distribution[sf.Vector2f](sf.Vector2f())
	p[0] = th.distributions.deflect(to_vector2f(direction), max_rotation)
	return wrap_vector2distribution(p)

def random(float begin, float end):
	return th.random(begin, end)

def random_dev(float middle, float deviation):
	return th.randomDev(middle, deviation)

def set_random_seed(unsigned long seed):
	th.setRandomSeed(seed)


cdef class Edge:
	cdef th.Edge[unsigned long] *p_this
	cdef object                     c0, c1
	cdef unsigned long              p_c0, p_c1

	def __init__(self, object corner0, object corner1):
		self.c0, self.c1 = corner0, corner1

		self.p_c0 = <unsigned long><void*>self.c0
		self.p_c1 = <unsigned long><void*>self.c1

		self.p_this = new th.Edge[unsigned long](self.p_c0, self.p_c1)

	def __dealloc__(self):
		del self.p_this

	def __getitem__(self, unsigned int key):
		return <object><void*>self.p_this[0][key]

cdef class Triangle:
	cdef th.Triangle[unsigned long] *p_this
	cdef object                         c0, c1, c2
	cdef unsigned long                  p_c0, p_c1, p_c2

	def __init__(self, object corner0, object corner1, object corner2):
		self.c0, self.c1, self.c2 = corner0, corner1, corner2

		self.p_c0 = <unsigned long><void*>self.c0
		self.p_c1 = <unsigned long><void*>self.c1
		self.p_c2 = <unsigned long><void*>self.c2

		self.p_this = new th.Triangle[unsigned long](self.p_c0, self.p_c1, self.p_c2)

	def __dealloc__(self):
		del self.p_this

	def __getitem__(self, unsigned int key):
		return <object><void*>self.p_this[0][key]
