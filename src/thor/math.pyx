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
