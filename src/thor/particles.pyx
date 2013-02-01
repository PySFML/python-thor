#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport dparticles
from dparticles cimport shared_ptr

cimport pysfml.dsystem
cimport pysfml.dgraphics

from pysfml.system cimport Time, wrap_time, Vector2
from pysfml.graphics cimport Color, wrap_color
from pysfml.graphics cimport Texture
from pysfml.graphics cimport Drawable
from pysfml.graphics cimport RenderTarget, RenderStates

from math cimport Distribution

cdef pysfml.dsystem.Vector2f vector2_to_vector2f(vector):
	x, y = vector
	return pysfml.dsystem.Vector2f(x, y)

cdef pysfml.dsystem.IntRect rectangle_to_intrect(rectangle):
	l, t, w, h = rectangle
	return pysfml.dsystem.IntRect(l, t, w, h)


cdef class Particle:
	cdef dparticles.Particle *p_this

	def __init__(self, Time total_lifetime):
		self.p_this = new dparticles.Particle(total_lifetime.p_this[0])

	def __dealloc__(self):
		del self.p_this

	property position:
		def __get__(self):
			return Vector2(self.p_this.position.x, self.p_this.position.y)

		def __set__(self, position):
			self.p_this.position = vector2_to_vector2f(position)

	property velocity:
		def __get__(self):
			return Vector2(self.p_this.velocity.x, self.p_this.velocity.y)

		def __set__(self, velocity):
			self.p_this.velocity = vector2_to_vector2f(velocity)

	property rotation:
		def __get__(self):
			return self.p_this.rotation

		def __set__(self, float rotation):
			self.p_this.rotation = rotation

	property rotation_speed:
		def __get__(self):
			return self.p_this.rotationSpeed

		def __set__(self, float rotation_speed):
			self.p_this.rotationSpeed = rotation_speed

	property scale:
		def __get__(self):
			return Vector2(self.p_this.scale.x, self.p_this.scale.y)

		def __set__(self, scale):
			self.p_this.scale = vector2_to_vector2f(scale)

	property color:
		def __get__(self):
			cdef pysfml.dgraphics.Color* p = new pysfml.dgraphics.Color()
			p[0] = self.p_this.color
			return wrap_color(p)

		def __set__(self, Color color):
			self.p_this.color = color.p_this[0]

cdef api object wrap_particle(dparticles.Particle *p):
	cdef Particle r = Particle.__new__(Particle)
	r.p_this = p
	return r

def get_passed_lifetime(Particle particle):
	cdef pysfml.dsystem.Time* p = new pysfml.dsystem.Time()
	p[0] = dparticles.getPassedLifetime(particle.p_this[0])
	return wrap_time(p)

def get_total_lifetime(Particle particle):
	cdef pysfml.dsystem.Time* p = new pysfml.dsystem.Time()
	p[0] = dparticles.getTotalLifetime(particle.p_this[0])
	return wrap_time(p)

def get_remaining_lifetime(Particle particle):
	cdef pysfml.dsystem.Time* p = new pysfml.dsystem.Time()
	p[0] = dparticles.getRemainingLifetime(particle.p_this[0])
	return wrap_time(p)

def get_passed_ratio(Particle particle):
	return dparticles.getPassedRatio(particle.p_this[0])

def get_remaining_ratio(Particle particle):
	return dparticles.getRemainingRatio(particle.p_this[0])


cdef class Emitter:
	cdef dparticles.emitter.Ptr p_emitter

	def __init__(self):
		if self.__class__ == Emitter:
			raise Exception("Emitter is abstract")

		self.p_emitter = dparticles.derivableemitter.create(self)

	def emit(self, EmitterAdder system, Time dt):
		pass


cdef class Affector:
	cdef dparticles.affector.Ptr p_affector

	def __init__(self):
		if self.__class__ == Affector:
			raise Exception("Affector is abstract")

		self.p_affector = dparticles.derivableaffector.create(self)

	def affect(self, Particle particle, Time dt):
		pass

cdef class ParticleSystem(Drawable):
	cdef dparticles.ParticleSystem *p_this

	def __cinit__(self, Texture texture, rectangle=None):
		if not rectangle:
			self.p_this = new dparticles.ParticleSystem(dparticles.shared_ptr[pysfml.dgraphics.Texture](texture.p_this))
		else:
			self.p_this = new dparticles.ParticleSystem(dparticles.shared_ptr[pysfml.dgraphics.Texture](texture.p_this), rectangle_to_intrect(rectangle))

	def __dealloc__(self):
		del self.p_this

	def draw(self, RenderTarget target, RenderStates states):
		target.p_rendertarget.draw((<pysfml.dgraphics.Drawable*>self.p_this)[0])

	def add_emitter(self, Emitter emitter, Time time_until_removal=None):
		if not time_until_removal:
			self.p_this.addEmitter(emitter.p_emitter)
		else:
			self.p_this.addEmitter(emitter.p_emitter, time_until_removal.p_this[0])

	def remove_emitter(self, Emitter emitter):
		self.p_this.removeEmitter(emitter.p_emitter)

	def clear_emitters(self):
		self.p_this.clearEmitters()

	def contains_emitter(self, Emitter emitter):
		return self.p_this.containsEmitter(emitter.p_emitter)

	def add_affector(self, Affector affector, Time time_until_removal=None):
		if not time_until_removal:
			self.p_this.addAffector(affector.p_affector)
		else:
			self.p_this.addAffector(affector.p_affector, time_until_removal.p_this[0])

	def remove_affector(self, Affector affector):
		self.p_this.removeAffector(affector.p_affector)

	def clear_affectors(self):
		self.p_this.clearAffectors()

	def contains_affector(self, Affector affector):
		return self.p_this.containsAffector(affector.p_affector)

	def update(self, Time dt):
		self.p_this.update(dt.p_this[0])

	def clear_particles(self):
		self.p_this.clearParticles()

	def swap(self, ParticleSystem other):
		self.p_this.swap(other.p_this[0])


cdef class EmitterAdder:
	cdef dparticles.emitter.Adder *p_this

	def add_particle(self, Particle particle):
		self.p_this.addParticle(particle.p_this[0])

cdef api object wrap_emitteradder(dparticles.emitter.Adder *p):
	cdef EmitterAdder r = EmitterAdder.__new__(EmitterAdder)
	r.p_this = p
	return r


ctypedef fused distributionType:
	object
	Distribution

cdef Distribution getDistribution(distributionType distribution):
	if distributionType is object:
		return Distribution(distribution)
	elif distributionType is Distribution:
		return distribution

cdef class UniversalEmitter(Emitter):
	cdef dparticles.universalemitter.Ptr p_this

	def __init__(self):
		self.p_this = dparticles.universalemitter.create()
		self.p_emitter = dparticles.castUniversalEmitter(self.p_this)

	property emission_rate:
		def __set__(self, float particles_per_second):
			self.p_this.get().setEmissionRate(particles_per_second)

	property particle_lifetime:
		def __set__(self, object particle_lifetime):
			cdef Distribution distribution = getDistribution(particle_lifetime)
			self.p_this.get().setParticleLifetime(distribution.p_this.getTimeFunctor())

	property particle_position:
		def __set__(self, object particle_position):
			cdef Distribution distribution = getDistribution(particle_position)
			self.p_this.get().setParticlePosition(distribution.p_this.getVector2Functor())

	property particle_velocity:
		def __set__(self, object particle_velocity):
			cdef Distribution distribution = getDistribution(particle_velocity)
			self.p_this.get().setParticleVelocity(distribution.p_this.getVector2Functor())

	property particle_rotation:
		def __set__(self, object particle_rotation):
			cdef Distribution distribution = getDistribution(particle_rotation)
			self.p_this.get().setParticleRotation(distribution.p_this.getFloatFunctor())

	property particle_rotation_speed:
		def __set__(self, object particle_rotation_speed):
			cdef Distribution distribution = getDistribution(particle_rotation_speed)
			self.p_this.get().setParticleRotationSpeed(distribution.p_this.getFloatFunctor())

	property particle_scale:
		def __set__(self, object particle_scale):
			cdef Distribution distribution = getDistribution(particle_scale)
			self.p_this.get().setParticleScale(distribution.p_this.getVector2Functor())

	property particle_color:
		def __set__(self, object particle_color):
			cdef Distribution distribution = getDistribution(particle_color)
			self.p_this.get().setParticleColor(distribution.p_this.getColorFunctor())


cdef class ForceAffector(Affector):
	cdef shared_ptr[dparticles.ForceAffector] p_this

	def __init__(self, acceleration):
		self.p_this = dparticles.forceaffector.create(vector2_to_vector2f(acceleration))
		self.p_affector = dparticles.castForceAffector(self.p_this)

	property acceleration:
		def __get__(self):
			cdef pysfml.dsystem.Vector2f p
			p = self.p_this.get().getAcceleration()
			return Vector2(p.x, p.y)

		def __set__(self, acceleration):
			self.p_this.get().setAcceleration(vector2_to_vector2f(acceleration))


cdef class TorqueAffector(Affector):
	cdef shared_ptr[dparticles.TorqueAffector] p_this

	def __init__(self, float angular_acceleration):
		self.p_this = dparticles.torqueaffector.create(angular_acceleration)
		self.p_affector = dparticles.castTorqueAffector(self.p_this)

	property angular_acceleration:
		def __get__(self):
			return self.p_this.get().getAngularAcceleration()

		def __set__(self, float angular_acceleration):
			self.p_this.get().setAngularAcceleration(angular_acceleration)


cimport danimation
from animation cimport FrameAnimation, ColorAnimation, FadeAnimation

ctypedef fused AnimationFunction:
	ColorAnimation
	FadeAnimation

cdef class AnimationAffector(Affector):
	cdef shared_ptr[dparticles.AnimationAffector] p_this

	@classmethod
	def create(cls, AnimationFunction particle_animation):
		cdef AnimationAffector r = AnimationAffector.__new__(AnimationAffector)

		if AnimationFunction is ColorAnimation:
			r.p_this = dparticles.animationaffector.create(<danimation.ColorAnimation>particle_animation.p_this[0])
			r.p_affector = dparticles.castAnimationAffector(r.p_this)
		elif AnimationFunction is FadeAnimation:
			r.p_this = dparticles.animationaffector.create(<danimation.FadeAnimation>particle_animation.p_this[0])
			r.p_affector = dparticles.castAnimationAffector(r.p_this)

		return r
