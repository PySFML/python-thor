#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from pysfml.dsystem cimport Vector2Object, Vector3Object

cdef extern from "vectors/PolarVector2Object.hpp" namespace "":
	cdef cppclass PolarVector2Object:
		PolarVector2Object()
		PolarVector2Object(object, object)
		object radius()
		void   radius(object)
		object angle()
		void   angle(object)
	
cdef extern from "Thor/Vectors.hpp" namespace "thor":
	#object length(Vector2Object&)
	object squaredLength(Vector2Object&)
	void setLength(Vector2Object&, object)
	Vector2Object unitVector(Vector2Object&)
	#object polarAngle(Vector2Object&)
	void setPolarAngle(Vector2Object&, object)
	void rotate(Vector2Object&, object)
	Vector2Object rotatedVector(Vector2Object&, object)
	Vector2Object perpendicularVector(Vector2Object&)
	object signedAngle(Vector2Object&, Vector2Object&)
	object dotProduct(Vector2Object&, Vector2Object&)
	Vector3Object crossProduct(Vector2Object&, Vector2Object&)
	Vector2Object componentwiseProduct(Vector2Object&, Vector2Object&)
	Vector2Object componentwiseQuotient(Vector2Object&, Vector2Object&)

	#object length(Vector3Object&)
	object squaredLength(Vector3Object&)
	Vector3Object unitVector(Vector3Object&)
	#object polarAngle(Vector3Object&)
	object elevationAngle(Vector3Object&)
	object dotProduct(Vector3Object&, Vector3Object&)
	Vector3Object crossProduct(Vector3Object&, Vector3Object&)
	Vector3Object componentwiseProduct(Vector3Object&, Vector3Object&)
	Vector3Object componentwiseQuotient(Vector3Object&, Vector3Object&)
	Vector3Object toVector3(Vector2Object&)
	
	object length(PolarVector2Object&)
	object polarAngle(PolarVector2Object&)
