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
		T* get()
		long use_count()

from pysfml.dsystem cimport Vector2f, Time
from pysfml.dgraphics cimport IntRect
from pysfml.dgraphics cimport Texture, Color

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

cimport emitter, affector

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

cdef extern from "particles/DerivableEmitter.hpp" namespace "":
	cdef cppclass DerivableEmitter:
		DerivableEmitter(object)

cdef extern from "particles/DerivableAffector.hpp" namespace "":
	cdef cppclass DerivableAffector:
		DerivableAffector(object)

cimport derivableemitter, derivableaffector

cdef extern from "Thor/Particles.hpp" namespace "thor":
	cdef cppclass UniversalEmitter:
		UniversalEmitter()
		void setEmissionRate(float)
		void setParticleLifetime(dmath.Distribution[Time])
		void setParticlePosition(dmath.Distribution[Vector2f])
		void setParticleVelocity(dmath.Distribution[Vector2f])
		void setParticleRotation(dmath.Distribution[float])
		void setParticleRotationSpeed(dmath.Distribution[float])
		void setParticleScale(dmath.Distribution[Vector2f])
		void setParticleColor(dmath.Distribution[Color])

cimport universalemitter


cdef extern from "Thor/Particles.hpp" namespace "thor":
	cdef cppclass ForceAffector:
		ForceAffector(Vector2f)
		void affect(Particle&, Time)
		Vector2f getAcceleration()
		void setAcceleration(Vector2f)

	cdef cppclass ScaleAffector:
		ScaleAffector(Vector2f)
		void affect(Particle&, Time)
		Vector2f getScaleFactor()
		void setScaleFactor(Vector2f)

	cdef cppclass TorqueAffector:
		TorqueAffector(float)
		void affect(Particle&, Time)
		void setAngularAcceleration(float)
		float getAngularAcceleration()

	cdef cppclass AnimationAffector

cimport torqueaffector, scaleaffector, forceaffector, animationaffector

cdef extern from "particles/utilities.hpp":
	emitter.Ptr castUniversalEmitter(universalemitter.Ptr)

	affector.Ptr castAnimationAffector(animationaffector.Ptr)
	affector.Ptr castTorqueAffector(torqueaffector.Ptr)
	affector.Ptr castScaleAffector(scaleaffector.Ptr)
	affector.Ptr castForceAffector(forceaffector.Ptr)
