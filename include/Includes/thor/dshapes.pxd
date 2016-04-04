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

from sfml cimport Vector2f, Color, Shape, ConvexShape

cdef extern from "Thor/Shapes.hpp" namespace "thor::Shapes":
    ConvexShape toConvexShape(const Shape&)

    ConvexShape line(Vector2f, const Color&)
    ConvexShape line(Vector2f, const Color&, float)

    ConvexShape roundedRect(Vector2f, float, const Color&)
    ConvexShape roundedRect(Vector2f, float, const Color&, float)
    ConvexShape roundedRect(Vector2f, float, const Color&, float, const Color&)

    ConvexShape polygon(size_t, float, const Color&)
    ConvexShape polygon(size_t, float, const Color&, float)
    ConvexShape polygon(size_t, float, const Color&, float, const Color&)

    ConvexShape star(size_t, float, float, const Color&)
    ConvexShape star(size_t, float, float, const Color&, float)
    ConvexShape star(size_t, float, float, const Color&, float, const Color&)
