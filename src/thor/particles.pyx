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

cimport pysfml.dsystem
cimport pysfml.dgraphics

from pysfml.system cimport Time, wrap_time, Vector2
from pysfml.graphics cimport Color, wrap_color

cdef pysfml.dsystem.Vector2f vector2_to_vector2f(vector):
	x, y = vector
	return pysfml.dsystem.Vector2f(x, y)

cdef class Particle:
	cdef dparticles.Particle *p_this

	def __cinit__(self, Time total_lifetime):
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
