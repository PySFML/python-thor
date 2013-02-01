#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from copy import copy
import sfml as sf
import thor as th

# various constants as firework parameters
EXPLOSION_INTERVAL  = sf.seconds(1)
EXPLOSION_DURATION  = sf.seconds(0.2)
TAIL_DURATION       = sf.seconds(2.5)
TAILS_PER_EXPLOSION = 15
GRAVITY             = 30

# array with possible colors for explosions
firework_colors = (
	sf.Color(100, 255, 135), # light green
	sf.Color(175, 255, 135), # lime green
	sf.Color(85, 190, 255),  # light blue
	sf.Color(255, 145, 255), # pink
	sf.Color(100, 100, 255), # indigo
	sf.Color(140, 250, 190), # turquoise
	sf.Color(255, 135, 135), # red
	sf.Color(240, 255, 135), # light yellow
	sf.Color(245, 215, 80)   # light orange
)

# custom emitter that groups particles in tails
class FireworkEmitter(th.Emitter):
	def __init__(self, position):
		th.Emitter.__init__(self)

		self._accumulated_time = copy(sf.Time.ZERO)
		self._position = copy(position)
		self._color = copy(firework_colors[int(th.random(0, len(firework_colors)-1))])

	def emit(self, system, dt):
		#TAIL_INTERVAL = EXPLOSION_DURATION / TAILS_PER_EXPLOSION
		TAIL_INTERVAL = sf.milliseconds(float(EXPLOSION_DURATION.milliseconds) / float(TAILS_PER_EXPLOSION))

		# accumulate passed time: if enough time has passed (TAIL_INTERVAL),
		# emit a new tail and decrease accumulator
		self._accumulated_time += dt

		while self._accumulated_time - TAIL_INTERVAL > sf.Time.ZERO:
			self._emit_tail(system)
			self._accumulated_time -= TAIL_INTERVAL

	def _emit_tail(self, system):
		# create initial direction with random vector length and angle
		velocity = th.PolarVector2(th.random(30, 70), th.random(0, 360))

		# create particle at position of explosion, with emitter-specific color
		# and at 80% initial scale
		particle = th.Particle(TAIL_DURATION)
		particle.position = self._position
		particle.color = self._color
		particle.scale = particle.scale * 0.8

		# a tail contains 25 particles with different speeds and scales
		# the largest particles move fastest, leading to a comet-like tail effect
		for i in range(25):
			# decrease scale continuously
			particle.scale *= 0.95

			# decrease speed continuously
			velocity.r = velocity.r * 0.96

			#particle.velocity = velocity
			particle.velocity = velocity.to_vector2()

			# add adapted particle to particle system
			system.add_particle(particle)

# custom affector that fades particles out and accelerates them according to scale
class FireworkAffector(th.Affector):
	def __init__(self):
		th.Affector.__init__(self)

	def affect(self, particle, dt):
		# apply gravity, where particles with greater scale are affected
		# stronger (quadratic influence)
		particle.velocity += sf.Vector2(0, GRAVITY) * dt.seconds * particle.scale.x * particle.scale.y
		#particle.velocity += dt.seconds * sf.Vector2(0, GRAVITY) * particle.scale.x * particle.scale.y

		# let particles continuously fade out (particles with smaller scale
		# have already lower alpha value at beginning)
		particle.color.a = 256 * th.get_remaining_ratio(particle) * particle.scale.x


# create render window
window = sf.RenderWindow(sf.VideoMode(800, 600), "pyThor - Fireworks", sf.Style.CLOSE)
window.vertical_synchronization = True

# load texture
try:
	texture = sf.Texture.from_file("Media/particle.png")
except IOError as error:
	print(error)
	exit(1)

# instantiate particle system and add custom affector
system = th.ParticleSystem(texture)
system.add_affector(FireworkAffector())

# create timer that can be connected to callbacks
# initial time limit is 1 second, timer immediately starts
explosion_timer = th.CallbackTimer()
explosion_timer.restart(sf.seconds(1))

# connect timer to a lambda expression which restarts the timer every time it
# expires
def trigger_function(trigger):
	trigger.restart(EXPLOSION_INTERVAL)
explosion_timer.connect(trigger_function)
#explosion_timer.connect(lambda trigger: trigger.restart(EXPLOSION_INTERVAL))

# connect timer to a lambda expression that creates an explosion at expiration
def trigger_function2(timer):
	# compute random position on screen
	position = sf.Vector2(th.random_dev(400, 300), th.random_dev(300, 200))

	# add a temporary emitter to the particle system
	system.add_emitter(FireworkEmitter(position), EXPLOSION_DURATION)

explosion_timer.connect(trigger_function2)

# main loop
running = True
frame_clock = sf.Clock()
states = sf.RenderStates()
states.blend_mode = sf.BlendMode.BLEND_ADD

while window.is_open:

	# event handling
	for event in window.events:
		if event == sf.CloseEvent:
			running = False

		if event == sf.KeyEvent and event.code == sf.Keyboard.ESCAPE:
			running = False

	# update particle system and timer
	system.update(frame_clock.restart())
	explosion_timer.update()

	# draw everything, using additive blend mode for better visual effects
	window.clear()
	#window.draw(system, sf.BlendMode.BLEND_ADD)
	window.draw(system, states)
	window.display()
