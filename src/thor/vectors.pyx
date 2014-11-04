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
cimport libcpp.thor as th


# TODO: replace PolarVector2Object with PolarVector2[object]
cdef class PolarVector2:
    cdef th.PolarVector2Object *p_this
    cdef object r, phi

    def __cinit__(self, object radius, object angle):
        self.p_this = new th.PolarVector2Object(radius, angle)
        self.r = radius
        self.phi = angle

    def __dealloc__(self):
        del self.p_this

    property r:
        def __get__(self):
            return self.r
            #return self.p_this.radius()

        def __set__(self, object r):
            self.p_this.radius(r)
            self.r = r

    property phi:
        def __get__(self):
            return self.phi
            #return self.p_this.angle()

        def __set__(self, object phi):
            self.p_this.angle(phi)
            self.phi = phi

    def to_vector2(self):
        r, phi = self.r, self.phi
        return (r*cos(phi), r*sin(phi))

## Disabled length and polar_angle because there's an issue with the
## current Vector2 design
#def length(PolarVector2 vector):
    #return th.length(vector.p_this[0])

#def polar_angle(PolarVector2 vector):
    #return th.polarAngle(vector.p_this[0])
