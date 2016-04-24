from sfml import sf
from thor import th

# create SFML window
window = sf.RenderWindow(sf.VideoMode(300, 200), "Thor - Time", sf.Style.CLOSE)
window.vertical_synchronization = True

# create stopwatch and timer
initial_time = sf.seconds(4)
stop_watch = th.StopWatch()
timer = th.CallbackTimer()
timer.reset(initial_time)

# load font
font = sf.Font.from_file("Media/sansation.ttf")

# create texts that display instructions and current time
instructions_text =  "S      Start/pause stopwatch\n"
instructions_text += "T      Start/pause timer\n"
instructions_text += "R      Reset stopwatch and timer\n"
instructions_text += "Esc  Quit"
instructions = sf.Text(instructions_text, font, 14)

stop_watch_measurement = sf.Text()
stop_watch_measurement.character_size = 20
stop_watch_measurement.font = font
stop_watch_measurement.position = (70, 120)
stop_watch_measurement.color = sf.Color(0, 190, 140)

timer_measurement = sf.Text()
timer_measurement.font = font
timer_measurement.character_size = 20
timer_measurement.position = (70, 150)
timer_measurement.color = sf.Color(0, 140, 190)

# connect timer with callback (colorize yellow) invoked at expiration time
def set_text_color_to_yellow(timer):
	timer_measurement.color = sf.Color.YELLOW

timer.connect(set_text_color_to_yellow)

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
				if stop_watch.is_running():
					stop_watch.stop()
				else:
					stop_watch.start()

			# T: start/pause timer
			elif event.code == sf.Keyboard.T:
				if timer.is_running():
					timer.stop()
				else:
					timer.start()

            # R: reset both stop_watch and timer
			elif event.code == sf.Keyboard.R:
				stop_watch.reset()
				timer.reset(initial_time)
				timer_measurement.color = sf.Color(0, 140, 190)

	# adapt texts for stop_watch and timer according to elapsed/remaining time
	stop_watch_measurement.string = "Stopwatch: {:.2f}".format(stop_watch.elapsed_time.seconds)
	timer_measurement.string = "Timer: {:.2f}".format(timer.remaining_time.seconds)

	# update triggering timer that allows the callback to be invoked
	timer.update()

	# draw everything
	window.clear()
	window.draw(instructions)
	window.draw(stop_watch_measurement)
	window.draw(timer_measurement)
	window.display()
