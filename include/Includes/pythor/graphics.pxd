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

cimport thor as th

cdef extern from "pythor/graphics.h":
    cdef class thor.graphics.BigTexture [object PyBigTextureObject]:
        cdef th.BigTexture *p_this

    cdef class thor.graphics.ColorGradient [object PyColorGradientObject]:
        cdef th.ColorGradient *p_this

cdef inline BigTexture wrap_bigtexture(th.BigTexture *p):
    cdef BigTexture r = BigTexture.__new__(BigTexture)
    r.p_this = p
    return r

cdef inline ColorGradient wrap_colorgradient(th.ColorGradient *p):
    cdef ColorGradient r = ColorGradient.__new__(ColorGradient)
    r.p_this = p
    return r
