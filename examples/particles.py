from sfml import sf
from thor import th

# create window
window = sf.RenderWindow(sf.VideoMode(800, 600), "pyThor - Particles")

# load image and initialize sprite
try:
	texture = sf.Texture.from_file("Media/particle.png")
except IOError as error:
	print(error)
	exit(1)

# create emitter
emitter = th.UniversalEmitter()
emitter.emission_rate = 30
emitter.particle_lifetime = sf.seconds(5)
emitter.particle_position = lambda: sf.Mouse.get_position(window)

# create particle system
system = th.ParticleSystem(texture)
system.add_emitter(emitter)

## build color gradient (green -> teal -> blue)
gradient = th.create_gradient([sf.Color(0, 150, 0), 1,
								sf.Color(0, 150, 100), 1,
								sf.Color(0, 0, 150)])

# create color and fade in/out animations
colorizer = th.ColorAnimation(gradient)
fader     = th.FadeAnimation(0.1, 0.1)

# add particle affectors
system.add_affector(th.AnimationAffector.create(colorizer))
system.add_affector(th.AnimationAffector.create(fader))
system.add_affector(th.TorqueAffector(100))
system.add_affector(th.ForceAffector((0, 100)))

# attributes that influence emitter
position = sf.Vector2()
velocity = th.PolarVector2(200, -90)
paused   = False

# load font
try:
	font = sf.Font.from_file("Media/sansation.ttf")
except IOError as error:
	print(error)
	exit(1)

# instruction text
instructions = sf.Text("Left click: Pause\n Mouse wheel: Change direction\n", font, 12)

# create clock to measure frame time
frame_clock = sf.Clock()

# main loop
while(True):
	# handle events
	for event in window.events:
		# [X]: quit
		if event == sf.CloseEvent:
			break

		# escape: quit
		elif event == sf.KeyEvent:
			if event.pressed:
				break

		# left mouse button: enable/disable glow
		elif event == sf.MouseButtonEvent and event.pressed:
			if event.button == sf.Mouse.LEFT:
				paused = not paused

		# mouse wheel: change emission direction
		elif event == sf.MouseWheelEvent:
			velocity.phi += 12 * event.delta


	# update particle system and emitter
	frame_time = frame_clock.restart()
	if not paused:
		system.update(frame_time)

	# set initial particle velocity, rotate vector randomly by maximal 10 degrees
	emitter.particle_velocity = th.deflect(velocity.to_vector2(), 10)

	# draw everything
	window.clear(sf.Color(30, 30, 30))
	window.draw(instructions)
	window.draw(system)
	window.display()
