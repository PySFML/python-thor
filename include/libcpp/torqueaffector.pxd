#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from libcpp.thor cimport shared_ptr
from libcpp.thor cimport TorqueAffector

cdef extern from "Thor/Particles.hpp" namespace "thor::TorqueAffector":
	ctypedef shared_ptr[TorqueAffector] Ptr
	Ptr create(float)
