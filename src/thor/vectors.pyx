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

from libc.math cimport cos, sin
cimport sfml as sf
cimport thor as th

from pysfml.system cimport NumericObject
from pysfml.system cimport Vector2, Vector3
from pysfml.system cimport wrap_vector2, wrap_vector3

cdef extern from "pythor/TrigonometricTraits.hpp":
    pass

__all__ = ['PolarVector2', 'length', 'squared_length', 'set_length',
    'unit_vector', 'polar_angle', 'set_polar_angle', 'rotate', 'rotated_vector',
    'perpendicular_vector', 'signed_angle', 'dot_product', 'cross_product',
    'cwise_product', 'cwise_quotient', 'projected_vector', 'elevation_angle',
    'to_vector3']

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

#    def __richcmp__(Vector2 self, other_, op):
#        cdef Vector2 other

#        if isinstance(other_, Vector2):
#            other = <Vector2>other_
#        else:
#            x, y = other_
#            other = Vector2(x, y)

#        if op == 2:
#            return self.p_this[0] == other.p_this[0]
#        elif op == 3:
#            return self.p_this[0] != other.p_this[0]
#        else:
#            raise NotImplemented

    def __iter__(self):
        return iter((self.r, self.phi))

#    def __copy__(self):
#        cdef th.PolarVector2[NumericObject] *p = new th.PolarVector2[NumericObject](self.p_this[0])
#        return wrap_polarvector2(p)

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

cdef api PolarVector2 wrap_polarvector2(th.PolarVector2[NumericObject]* p):
    cdef PolarVector2 r = PolarVector2.__new__(PolarVector2)
    r.p_this = p
    return r

#cdef api object wrap_vector2f(sf.Vector2f p):
#    cdef Vector2 r = Vector2.__new__(Vector2)
#    r.x = p.x
#    r.y = p.y
#    return r

#cdef api sf.Vector2f to_vector2f(vector):
#    x, y = vector
#    return sf.Vector2f(x, y)

def length(vector):
    if isinstance(vector, Vector2):
        th.length((<Vector2>vector).p_this[0])
    elif isinstance(vector, Vector3):
        th.length((<Vector3>vector).p_this[0])
    elif isinstance(vector, PolarVector2):
        th.length((<PolarVector2>vector).p_this[0])
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2, sfml.system.Vector3 or thor.vectors.PolarVector2)")

def squared_length(vector):
    if isinstance(vector, Vector2):
        th.squaredLength((<Vector2>vector).p_this[0])
    elif isinstance(vector, Vector3):
        th.squaredLength((<Vector3>vector).p_this[0])
    else:
        raise TypeError("Argument 'vector' has incorrect type (expected sfml.system.Vector2 or sfml.system.Vector3)")

def set_length(vector, new_length):
    if isinstance(vector, Vector2):
        th.squaredLength((<Vector2>vector).p_this[0])
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
