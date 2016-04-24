# PyThor - Python bindings for Thor
# Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PyThor project and is available under the zlib
# license.

"""
    Mathematical functionality, such as random number generator or
    trigonometric wrappers.
"""

# todo list
# ---------
# * support constructing distribution function with a constant
# * seperate definition in .inl files in TrigonometricTraits.hpp and TriangulationTraits.hpp
# * implement Py_triangulateConstrained() in Triangulation.cpp
# * implement Py_triangulatePolygon() in Triangulation.cpp
# * fix-me: add exception description in Edge and Triangle __getitem__
# * fix-me: in Distribution.cpp replace wrap_time with non pointer version
# * check return values and propagate errors in Triangulation.cpp, TrigonometricTraits.hpp and TriangulationTraits.hpp
# * finish implementation of traits TrigonometricTraits.hpp

__all__ = ['Distribution', 'Distributions', 'Edge', 'Triangle',
    'triangulate', 'triangulate_constrained', 'triangulate_polygon',
    'random', 'random_dev', 'set_random_seed','PI', 'to_degree',
    'to_radian']

cimport cython
cimport sfml as sf
cimport thor as th

from pysfml.system cimport Time, PyVector2Object
from pysfml.system cimport to_vector2f, Vector2
from pysfml.system cimport import_sfml__system

cdef extern from "Vertex.hpp":
    cdef cppclass Vertex:
        Vertex()
        Vertex(object)

        object get()
        void set(object)

cdef extern from "Triangulation.hpp":
    object Py_triangulate(object)
    object Py_triangulateConstrained(object, object)
    object Py_triangulatePolygon(object)

cdef extern from "Rule.hpp":
    cdef cppclass Rule:
        Rule()
        Rule(object)

        object get()
        void set(object)

cdef extern from "Distribution.hpp":
    cdef cppclass DistributionFunctor:
        DistributionFunctor(object)

    th.Function wrapDistributionFunctor(DistributionFunctor)

    cdef cppclass IntDistribution:
        IntDistribution(th.Distribution[int]*)

    cdef cppclass FloatDistribution:
        FloatDistribution(th.Distribution[float]*)

    cdef cppclass Vector2fDistribution:
        Vector2fDistribution(th.Distribution[sf.Vector2f]*)

    cdef cppclass TimeDistribution:
        TimeDistribution(th.Distribution[sf.Time]*)

    th.Function wrapDistributionInt(IntDistribution)
    th.Function wrapDistributionFloat(FloatDistribution)
    th.Function wrapDistributionVector2f(Vector2fDistribution)
    th.Function wrapDistributionTime(TimeDistribution)

cdef extern from "TrigonometricTraits.hpp":
    pass

import_sfml__system()

cdef class Distribution:
    cdef th.Distribution[Rule] *p_this

    def __cinit__(self):
        self.p_this = NULL

    def __init__(self, function):
        self.p_this = new th.Distribution[Rule](wrapDistributionFunctor(DistributionFunctor(function)))

    def __dealloc__(self):
        if self.p_this:
            del self.p_this

    def __call__(self):
        return self.p_this[0]().get()

cdef Distribution wrap_int_distribution(th.Distribution[int] *p):
   cdef Distribution r = Distribution.__new__(Distribution)
   r.p_this = new th.Distribution[Rule](wrapDistributionInt(IntDistribution(p)))
   return r

cdef Distribution wrap_float_distribution(th.Distribution[float] *p):
   cdef Distribution r = Distribution.__new__(Distribution)
   r.p_this = new th.Distribution[Rule](wrapDistributionFloat(FloatDistribution(p)))
   return r

cdef Distribution wrap_vector2f_distribution(th.Distribution[sf.Vector2f] *p):
   cdef Distribution r = Distribution.__new__(Distribution)
   r.p_this = new th.Distribution[Rule](wrapDistributionVector2f(Vector2fDistribution(p)))
   return r

cdef Distribution wrap_time_distribution(th.Distribution[sf.Time] *p):
   cdef Distribution r = Distribution.__new__(Distribution)
   r.p_this = new th.Distribution[Rule](wrapDistributionTime(TimeDistribution(p)))
   return r

ctypedef fused DistributionType:
    cython.int
    cython.float
    Time

class Distributions:

    @staticmethod
    def uniform(DistributionType min_, DistributionType max_):
        cdef th.Distribution[int] *pi
        cdef th.Distribution[float] *pf
        cdef th.Distribution[sf.Time] *pt

        if DistributionType is cython.int:
            pi = new th.Distribution[int](0)
            pi[0] = th.distributions.uniform(min_, max_)
            return wrap_int_distribution(pi)
        elif DistributionType is cython.float:
            pf = new th.Distribution[float](0)
            pf[0] = th.distributions.uniform(min_, max_)
            return wrap_float_distribution(pf)
        elif DistributionType is Time:
            pt = new th.Distribution[sf.Time](sf.seconds(0))
            pt[0] = th.distributions.uniform(min_.p_this[0], max_.p_this[0])
            return wrap_time_distribution(pt)

    @staticmethod
    def rect(center, half_size):
        cdef th.Distribution[sf.Vector2f] *p = new th.Distribution[sf.Vector2f](sf.Vector2f())
        p[0] = th.distributions.rect(to_vector2f(center), to_vector2f(half_size))
        return wrap_vector2f_distribution(p)

    @staticmethod
    def circle(center, radius):
        cdef th.Distribution[sf.Vector2f] *p = new th.Distribution[sf.Vector2f](sf.Vector2f())
        p[0] = th.distributions.circle(to_vector2f(center), radius)
        return wrap_vector2f_distribution(p)

    @staticmethod
    def deflect(direction, max_rotation):
        cdef th.Distribution[sf.Vector2f] *p = new th.Distribution[sf.Vector2f](sf.Vector2f())
        p[0] = th.distributions.deflect(to_vector2f(direction), max_rotation)
        return wrap_vector2f_distribution(p)

cdef class Edge:
    cdef th.Edge[Vertex] *p_this
    cdef Vertex corner0, corner1

    def __cinit__(self, corner0, corner1):
        self.corner0.set(corner0)
        self.corner1.set(corner1)

        self.p_this = new th.Edge[Vertex](self.corner0, self.corner1)

    def __dealloc__(self):
        del self.p_this

    def __getitem__(self, size_t corner_index):
        if corner_index >= 2:
            # fix-me: add exception description
            raise IndexError

        return self.p_this[0][corner_index].get()

cdef class Triangle:
    cdef th.Triangle[Vertex] *p_this
    cdef Vertex corner0, corner1, corner2

    def __cinit__(self, corner0, corner1, corner2):
        self.corner0.set(corner0)
        self.corner1.set(corner1)
        self.corner2.set(corner2)

        self.p_this = new th.Triangle[Vertex](self.corner0, self.corner1, self.corner2)

    def __dealloc__(self):
        del self.p_this

    def __getitem__(self, size_t corner_index):
        if corner_index >= 3:
            # fix-me: add exception description
            raise IndexError

        return self.p_this[0][corner_index].get()

cdef api object create_triangle(object corner0, object corner1, object corner2):
    return Triangle(corner0, corner1, corner2)

def triangulate(vertices):
    return Py_triangulate(list(vertices))

def triangulate_constrained(vertices, constrained_edges):
    raise NotImplementedError
#    return Py_triangulateConstrained(vertices, constrained_edges)

def triangulate_polygon(vertices):
    raise NotImplementedError
#    return Py_triangulatePolygon(vertices)

def random(cython.numeric min, cython.numeric max):
    if cython.numeric is short or cython.numeric is int:
        return th.random(min, max)
    elif cython.numeric is float:
        return th.random(min, max)

def random_dev(float middle, float deviation):
    return th.randomDev(middle, deviation)

def set_random_seed(unsigned long seed):
    th.setRandomSeed(seed)

PI = th.Pi

def to_degree(radian):
    return th.toDegree(radian)

def to_radian(degree):
    return th.toRadian(degree)
