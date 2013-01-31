#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from pysfml.dsystem cimport Vector2f
from dparticles cimport shared_ptr
from dparticles cimport ForceAffector

cdef extern from "Thor/Particles.hpp" namespace "thor::ForceAffector":
	ctypedef shared_ptr[ForceAffector] Ptr
	Ptr create(Vector2f)
