#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport libcpp.thor as th

cdef extern from "pythor/graphics.h":
	cdef class thor.graphics.ColorGradient [object PyColorGradientObject]:
		cdef th.ColorGradient *p_this
