#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cdef extern from "vectors/PolarVector2Object.hpp" namespace "":
	cdef cppclass PolarVector2Object:
		PolarVector2Object()
		PolarVector2Object(object, object)
		object radius()
		void   radius(object)
		object angle()
		void   angle(object)
