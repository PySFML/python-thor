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

# create render window
window = sf.RenderWindow(sf.VideoMode(600, 500), "pyThor - Shapes", sf.Style.CLOSE)
window.vertical_synchronization = True

# create a concave shape by directly inserting the polygon points
concave_shape = th.ConcaveShape()
concave_shape.point_count = 5
concave_shape.set_point(0, (50, 50))
concave_shape.set_point(1, (100, 100))
concave_shape.set_point(2, (150, 50))
concave_shape.set_point(3, (150, 200))
concave_shape.set_point(4, (50, 150))
concave_shape.set_point(4, (50, 150))
concave_shape.outline_thickness = 2
concave_shape.fill_color = sf.Color(150, 100, 100)
concave_shape.outline_color = sf.Color(200, 100, 100)

# create th.ConcaveShape shape from sf.Shape
circle = sf.CircleShape(60)
circle.fill_color = sf.Color(0, 200, 0)
circle.move((40, 340))

# create a few predefined shapes
pie = th.pie(60, 135, sf.Color.GREEN)
polygon = th.polygon(7, 60, sf.Color.TRANSPARENT, 3, sf.Color(175, 40, 250))
star = th.star(7, 40, 60, sf.Color(255, 255, 10), 5, sf.Color(250, 190, 20))

# move star and polygon shapes
pie.move((100, 400))
star.move((500, 100))
polygon.move((500, 100))

# create an arrow pointing towards the mouse cursor
arrow = th.Arrow(window.size/2, (0, 0), sf.Color(0, 150, 200))

# create clock to measure frame time
frame_clock = sf.Clock()

# main loop
running = True

while running:
	for event in window.events:
		if event in [sf.CloseEvent, sf.KeyEvent]:
			running = False

		if event == sf.MouseMoveEvent:
			arrow.direction = event.position - window.size / 2

	# rotate polygon and star
	elapsed = frame_clock.restart()
	polygon.rotate(20 * elapsed.seconds)
	star.rotate(45 * elapsed.seconds)

	# draw everything
	window.clear()
	window.draw(concave_shape)
	window.draw(circle)
	window.draw(pie)
	window.draw(polygon)
	window.draw(star)
	window.draw(arrow)
	window.display()
