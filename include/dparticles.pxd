#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport dmath

cdef extern from "<memory>" namespace "std":
	cdef cppclass shared_ptr[T]:
		shared_ptr()
		shared_ptr(T* ptr)

from pysfml.dsystem cimport Vector2f, Time
from pysfml.dgraphics cimport IntRect
from pysfml.dgraphics cimport Texture, Color

cimport emitter

cdef extern from "Thor/Particles.hpp" namespace "thor":

	cdef cppclass Particle:
		Particle(Time)
		Vector2f position
		Vector2f velocity
		float rotation
		float rotationSpeed
		Vector2f scale
		Color color

	cdef Time getPassedLifetime(Particle&)
	cdef Time getTotalLifetime(Particle&)
	cdef Time getRemainingLifetime(Particle&)
	cdef float getPassedRatio(Particle&)
	cdef float getRemainingRatio(Particle&)

	cdef cppclass Affector
	cdef cppclass Emitter

cimport emitter

cdef extern from "Thor/Particles.hpp" namespace "thor":
	cdef cppclass ParticleSystem:
		ParticleSystem(shared_ptr[Texture])
		ParticleSystem(shared_ptr[Texture], IntRect&)
		void swap(ParticleSystem&)
		void addAffector(shared_ptr[Affector])
		void addAffector(shared_ptr[Affector], Time)
		void removeAffector(shared_ptr[Affector])
		void clearAffectors()
		bint containsAffector(shared_ptr[Affector])
		void addEmitter(shared_ptr[Emitter])
		void addEmitter(shared_ptr[Emitter], Time)
		void removeEmitter(shared_ptr[Emitter])
		void clearEmitters()
		bint containsEmitter(shared_ptr[Emitter])
		void update(Time)
		void clearParticles()
