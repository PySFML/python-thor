#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


import sfml as sf
import thor as th

def find_vertex(vertices, position):
	return
	#for itr in vertices:
		#th.squared_length(position - itr) <= 36:
			#return itr

def handle_vertex_click(mouse_event, vertices):
	# handles clicks on a vertex
	# returns true if a new triangulation is required
	click_pos = mouse_event.position

	# add point when left-clicking
	if mouse_event.button == sf.Mouse.LEFT:
		# don't insert the same point twice
		if click_pos in vertices:
			return False

		# if not contained yet, insert point
		vertices.append(click_pos)
		return True

	# remove point when right-clicking
	if mouse_event.button == sf.Mouse.RIGHT:
		vertex = find_vertex(vertices, click_pos)

		if vertex:
			try:
				vertices.remove(click_pos)
			except ValueError:
				pass

			return True

	return False

def handle_events(window, vertices, triangles):
	# handles sfml events
	# returns false if the application should be quit

	for event in window.events:
		# mouse buttons: add or remove vertex
		if event == sf.MouseButtonEvent and event.pressed:
			# compute new triangulation for points if necessary
			if handle_vertex_click(event, vertices):
				del triangles[:]
				triangles[:] = th.triangulate(vertices)

		# keys (C -> clear, Esc -> quit)
		elif event == sf.KeyEvent and event.pressed:
			if event.code == sf.Keyboard.ESCAPE:
				return False

			if event.code == sf.Keyboard.C:
				del vertices[:]
				del triangles[:]

		elif event == sf.CloseEvent:
			return False

	return True

# create window
window = sf.RenderWindow(sf.VideoMode(640, 480), "pyThor - Triangulation", sf.Style.CLOSE)
window.framerate_limit = 20

# create containers in which we store the vertices and the computed triangles
vertices = []
triangles = []

# load font
try:
	font = sf.Font.from_file("Media/sansation.ttf")
except IOError as error:
	print(error)
	exit(1)

# description with instructions
instructions = "Left click to add point\n"
instructions += "Right click to remove point\n"
instructions += "C key to clear everything"
instructions = sf.Text(instructions, font, 12)

# main loop
running = True

while running:

	# event handling, possible quit
	if not handle_events(window, vertices, triangles):
		running = False

	# clear background
	window.clear()

	# draw all triangles
	for itr in triangles:
		triangle = sf.ConvexShape()
		triangle.point_count = 3
		triangle.fill_color = sf.Color(0, 150, 255, 100)
		triangle.outline_color = sf.Color.BLUE
		triangle.outline_thickness = 1
		for i in range(3):
			triangle.set_point(i, itr[i])

		window.draw(triangle)

	# draw all points
	for itr in vertices:
		circle = sf.CircleShape()
		circle.position = itr - (6, 6)
		circle.radius = 6
		circle.fill_color = sf.Color(255, 0, 150)

		window.draw(circle)

	# draw description and update screen
	window.draw(instructions)
	window.display()
