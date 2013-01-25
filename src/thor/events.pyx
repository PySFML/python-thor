#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport devents

cdef public class Connection[type PyConnectionType, object PyConnectionObject]:
	cdef devents.Connection *p_this

	def __init__(self):
		self.p_this = new devents.Connection()

	def __dealloc__(self):
		del self.p_this

	def is_connected(self):
		return self.p_this.isConnected()

	def invalidate(self):
		self.p_this.invalidate()

	def disconnect(self):
		self.p_this.disconnect()
