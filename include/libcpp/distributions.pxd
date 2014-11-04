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

from libcpp.sfml cimport Vector2f, Time

# The following code should be replaced by `from dmath cimport Distribution`
# but with the current Cython compiler (v0.17.4) it results a crash:
# Output: include/distributions.pxd:22:20: Compiler crash in
# AnalyseDeclarationsTransform
cdef extern from "Thor/Math.hpp" namespace "thor":
	cdef cppclass Distribution[T]:
		Distribution(T)

cdef extern from "Thor/Math.hpp" namespace "thor::Distributions":
	Distribution[float] uniform(float, float)
	Distribution[Time]  uniform(Time, Time)
	Distribution[Vector2f] rect(Vector2f, Vector2f)
	Distribution[Vector2f] circle(Vector2f, float)
	Distribution[Vector2f] deflect(Vector2f, float)
