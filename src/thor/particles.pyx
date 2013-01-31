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
