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

# create SFML window
window = sf.RenderWindow(sf.VideoMode(300, 200), "pyThor - Time", sf.Style.CLOSE)
window.vertical_synchronization = True

# create stopwatch and timer
initial_time = sf.seconds(4)
stop_watch = th.StopWatch()
timer = th.CallbackTimer()
timer.reset(initial_time)

# load font
try:
	font = sf.Font.from_file("Media/sansation.ttf")
except IOError as error:
	print(error)
	exit(1)

# create texts that display instructions and current time
instructions = "S      Start/pause stopwatch\n"
instructions += "T      Start/pause timer\n"
instructions += "R      Reset stopwatch and timer\n"
instructions += "Esc  Quit"
instructions = sf.Text(instructions, font, 12)


stop_watch_measurement = sf.Text()
stop_watch_measurement.character_size = 20
stop_watch_measurement.font = font
stop_watch_measurement.position = (70, 120)
stop_watch_measurement.color = sf.Color(0, 190, 140)

timer_measurement = sf.Text()
timer_measurement.character_size = 20
timer_measurement.font = font
timer_measurement.position = (70, 150)
timer_measurement.color = sf.Color(0, 140, 190)


# connect timer with callback (colorize yellow) invoked at expiration time
def set_timer_measurement_color_to_yellow():
	timer_measurement.color = sf.Color.YELLOW

timer.connect(set_timer_measurement_color_to_yellow)

# main loop
running = True
while running:

	# event handling
	for event in window.events:

		# [X]: quit
		if event == sf.CloseEvent:
			running = False

		elif event == sf.KeyEvent and event.pressed:
			# Esc: quit
			if event.code == sf.Keyboard.ESCAPE:
				running = False

			# S: start/pause stop_watch
			elif event.code == sf.Keyboard.S:
				if stop_watch.running:
					stop_watch.stop()
				else:
					stop_watch.start()

			# T: start/pause timer
			elif event.code == sf.Keyboard.T:
				if timer.running:
					timer.stop()
				else:
					timer.start()

			elif event.code == sf.Keyboard.R:
				stop_watch.reset()
				timer.reset(initial_time)
				timer_measurement.color = sf.Color(0, 140, 190)

	# adapt texts for stop_watch and timer according to elapsed/remaining time
	stop_watch_measurement.string = "Stopwatch:  " + str(stop_watch.elapsed_time)
	timer_measurement.string = "Timer:  " + str(timer.remaining_time)

	# update timer to invoke callbacks (if any) if expired
	timer.update()

	# draw everything
	window.clear()
	window.draw(instructions)
	window.draw(stop_watch_measurement)
	window.draw(timer_measurement)
	window.display()

