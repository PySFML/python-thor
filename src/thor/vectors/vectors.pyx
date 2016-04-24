# PyThor - Python bindings for Thor
# Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PyThor project and is available under the zlib
# license.

"""
    A lot of operations based on sf::Vector2 and sf::Vector3.
"""

# todo list
# ---------
# * fix PolarVector2.to_vector2() because it results in segfault
# * check if to_vector2 is how we're supposed to support this feature
# * make functions more tolerant to vector type; accept tuple for sf.Vector2 arguments for instance
# * fix the bug that prevent wrapping up an instance of sf::Vector2 and sf::Vector3

cimport sfml as sf
cimport thor as th

from pysfml.system cimport NumericObject
from pysfml.system cimport Vector2, Vector3
from pysfml.system cimport wrap_vector2, wrap_vector3

__all__ = ['PolarVector2', 'length', 'squared_length', 'set_length',
    'unit_vector', 'polar_angle', 'set_polar_angle', 'rotate', 'rotated_vector',
    'perpendicular_vector', 'signed_angle', 'dot_product', 'cross_product',
    'cwise_product', 'cwise_quotient', 'projected_vector', 'elevation_angle',
    'to_vector3']

cdef extern from "../math/TrigonometricTraits.hpp":
    pass

cdef extern from "PolarVector2.hpp":
    sf.Vector2[NumericObject]* conversionToVector2(th.PolarVector2[NumericObject]*)

cdef public class PolarVector2[type PyPolarVector2Type, object PyPolarVector2Object]:
    cdef th.PolarVector2[NumericObject] *p_this

    def __cinit__(self):
        self.p_this = new th.PolarVector2[NumericObject]()

    def __dealloc__(self):
        del self.p_this

    def __init__(self, r=0, phi=0):
        self.r = r
        self.phi = phi

    def __repr__(self):
        return "PolarVector2(r={0}, phi={1})".format(self.r, self.phi)

    def __str__(self):
        return "({0}, {1})".format(self.r, self.phi)

    def __iter__(self):
        return iter((self.r, self.phi))

    def __copy__(self):
        cdef th.PolarVector2[NumericObject] *p = new th.PolarVector2[NumericObject]()
        p[0] = self.p_this[0]
        return wrap_polarvector2(p)

    property r:
        def __get__(self):
            return self.p_this.r.get()

        def __set__(self, object r):
            self.p_this.r.set(r)

    property phi:
        def __get__(self):
            return self.p_this.phi.get()

        def __set__(self, object phi):
            self.p_this.phi.set(phi)

    def to_vector2(self):
        cdef sf.Vector2[NumericObject]* p = conversionToVector2(self.p_this)
        return wrap_vector2(p)

cdef api PolarVector2 wrap_polarvector2(th.PolarVector2[NumericObject]* p):
    cdef PolarVector2 r = PolarVector2.__new__(PolarVector2)
    r.p_this = p
    return r

def length(vector):
    if isinstance(vector, Vector2):
        return th.length((<Vector2>vector).p_this[0]).get()
    elif isinstance(vector, Vector3):
        return th.length((<Vector3>vector).p_this[0]).get()
    elif isinstance(vector, PolarVector2):
        return th.length((<PolarVector2>vector).p_this[0]).get()
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2, sfml.system.Vector3 or thor.vectors.PolarVector2)")

def squared_length(vector):
    if isinstance(vector, Vector2):
        return th.squaredLength((<Vector2>vector).p_this[0]).get()
    elif isinstance(vector, Vector3):
        return th.squaredLength((<Vector3>vector).p_this[0]).get()
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2 or sfml.system.Vector3)")

def set_length(vector, new_length):
    if isinstance(vector, Vector2):
        th.setLength((<Vector2>vector).p_this[0], NumericObject(new_length))
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2)")

def unit_vector(vector):
    cdef sf.Vector2[NumericObject]* vec2
    cdef sf.Vector3[NumericObject]* vec3

    if isinstance(vector, Vector2):
        vec2 = new sf.Vector2[NumericObject]()
        vec2[0] = th.unitVector((<Vector2>vector).p_this[0])
        return wrap_vector2(vec2)
    elif isinstance(vector, Vector3):
        vec3 = new sf.Vector3[NumericObject]()
        vec3[0] = th.unitVector((<Vector3>vector).p_this[0])
        return wrap_vector3(vec3)
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2 or sfml.system.Vector3)")

def polar_angle(vector):
    if isinstance(vector, Vector2):
        return th.polarAngle((<Vector2>vector).p_this[0]).get()
    elif isinstance(vector, Vector3):
        return th.polarAngle((<Vector3>vector).p_this[0]).get()
    elif isinstance(vector, PolarVector2):
        return th.polarAngle((<PolarVector2>vector).p_this[0]).get()
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2, sfml.system.Vector3 or thor.vectors.PolarVector2)")

def set_polar_angle(vector, polar_angle):
    if isinstance(vector, Vector2):
        th.setPolarAngle((<Vector2>vector).p_this[0], NumericObject(polar_angle))
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2)")

def rotate(vector, angle):
    if isinstance(vector, Vector2):
        th.rotate((<Vector2>vector).p_this[0], NumericObject(angle))
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2)")

def rotated_vector(vector, angle):
    cdef sf.Vector2[NumericObject]* p

    if isinstance(vector, Vector2):
        p = new sf.Vector2[NumericObject]()
        p[0] = th.rotatedVector((<Vector2>vector).p_this[0], NumericObject(angle))
        return wrap_vector2(p)
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2)")

def perpendicular_vector(vector):
    cdef sf.Vector2[NumericObject]* p

    if isinstance(vector, Vector2):
        p = new sf.Vector2[NumericObject]()
        p[0] = th.perpendicularVector((<Vector2>vector).p_this[0])
        return wrap_vector2(p)
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2)")

def signed_angle(lhs, rhs):
    if isinstance(lhs, Vector2) and isinstance(rhs, Vector2):
        return th.signedAngle((<Vector2>lhs).p_this[0], (<Vector2>rhs).p_this[0]).get()
    else:
        raise TypeError("Argument 'lhs' or 'rhs' has incorrect type (expected sfml.system.Vector2)")

def dot_product(lhs, rhs):
    if isinstance(lhs, Vector2) and isinstance(rhs, Vector2):
        return th.dotProduct((<Vector2>lhs).p_this[0], (<Vector2>rhs).p_this[0]).get()
    elif isinstance(lhs, Vector3) and isinstance(rhs, Vector3):
        return th.dotProduct((<Vector3>lhs).p_this[0], (<Vector3>rhs).p_this[0]).get()
    else:
        raise TypeError("Argument 'lhs' or 'rhs' has incorrect type (expected sfml.system.Vector2 or sfml.system.Vector3)")

def cross_product(lhs, rhs):
    cdef sf.Vector3[NumericObject]* p

    if isinstance(lhs, Vector2) and isinstance(rhs, Vector2):
        return th.crossProduct((<Vector2>lhs).p_this[0], (<Vector2>rhs).p_this[0]).get()
    elif isinstance(lhs, Vector3) and isinstance(rhs, Vector3):
        p = new sf.Vector3[NumericObject]()
        p[0] = th.crossProduct((<Vector3>lhs).p_this[0], (<Vector3>rhs).p_this[0])
        return wrap_vector3(p)
    else:
        raise TypeError("Argument 'lhs' or 'rhs' has incorrect type (expected sfml.system.Vector2 or sfml.system.Vector3)")

def cwise_product(lhs, rhs):
    cdef sf.Vector2[NumericObject]* vec2
    cdef sf.Vector3[NumericObject]* vec3

    if isinstance(lhs, Vector2) and isinstance(rhs, Vector2):
        vec2 = new sf.Vector2[NumericObject]()
        vec2[0] = th.cwiseProduct((<Vector2>lhs).p_this[0], (<Vector2>rhs).p_this[0])
        return wrap_vector2(vec2)
    elif isinstance(lhs, Vector3) and isinstance(rhs, Vector3):
        vec3 = new sf.Vector3[NumericObject]()
        vec3[0] = th.cwiseProduct((<Vector3>lhs).p_this[0], (<Vector3>rhs).p_this[0])
        return wrap_vector3(vec3)
    else:
        raise TypeError("Argument 'lhs' or 'rhs' has incorrect type (expected sfml.system.Vector2 or sfml.system.Vector3)")

def cwise_quotient(lhs, rhs):
    cdef sf.Vector2[NumericObject]* vec2
    cdef sf.Vector3[NumericObject]* vec3

    if isinstance(lhs, Vector2) and isinstance(rhs, Vector2):
        vec2 = new sf.Vector2[NumericObject]()
        vec2[0] = th.cwiseQuotient((<Vector2>lhs).p_this[0], (<Vector2>rhs).p_this[0])
        return wrap_vector2(vec2)
    elif isinstance(lhs, Vector3) and isinstance(rhs, Vector3):
        vec3 = new sf.Vector3[NumericObject]()
        vec3[0] = th.cwiseQuotient((<Vector3>lhs).p_this[0], (<Vector3>rhs).p_this[0])
        return wrap_vector3(vec3)
    else:
        raise TypeError("Argument 'lhs' or 'rhs' has incorrect type (expected sfml.system.Vector2 or sfml.system.Vector3)")

def projected_vector(vector, axis):
    cdef sf.Vector2[NumericObject]* p

    if isinstance(vector, Vector2) and isinstance(axis, Vector2):
        p = new sf.Vector2[NumericObject]()
        p[0] = th.projectedVector((<Vector2>vector).p_this[0], (<Vector2>axis).p_this[0])
        return wrap_vector2(p)
    else:
        raise TypeError("Argument 'vector' or 'axis' has incorrect type (expected sfml.system.Vector2)")

def elevation_angle(vector):
    if isinstance(vector, Vector3):
        return th.elevationAngle((<Vector3>vector).p_this[0]).get()
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector3)")

def to_vector3(vector2):
    cdef sf.Vector3[NumericObject]* p

    if isinstance(vector2, Vector2):
        p = new sf.Vector3[NumericObject]()
        p[0] = th.toVector3((<Vector2>vector2).p_this[0])
        return wrap_vector3(p)
    else:
        raise TypeError("Argument 'vector2' has incorrect type (expected sfml.system.Vector2)")
