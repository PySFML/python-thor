from sfml import sf
from thor import th

# create render window
window = sf.RenderWindow(sf.VideoMode(600, 500), "Thor - Shapes", sf.Style.CLOSE)
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
circle = th.ConcaveShape.from_shape(sf.CircleShape(60))
circle.fill_color = sf.Color(0, 200, 0)
circle.move((40, 340))

# create a few predefined shapes
polygon = th.Shapes.polygon(7, 60, sf.Color.TRANSPARENT, 3, sf.Color(175, 40, 250))
star = th.Shapes.star(7, 40, 60, sf.Color(255, 255, 10), 5, sf.Color(250, 190, 20))
rounded_rect = th.Shapes.rounded_rect(sf.Vector2(200, 100), 30, sf.Color(200, 190, 120), 3, sf.Color(150, 140, 80))

# move star and polygon shapes
star.move((480, 120))
polygon.move((480, 120))
rounded_rect.move((380, 350))

# create clock to measure frame time
frame_clock = sf.Clock()

# main loop
running = True

while running:
	for event in window.events:
		if event in [sf.CloseEvent, sf.KeyEvent]:
			running = False

	# rotate polygon and star
	elapsed = frame_clock.restart()
	polygon.rotate(20 * elapsed.seconds)
	star.rotate(45 * elapsed.seconds)

	# draw everything
	window.clear()
	window.draw(concave_shape)
	window.draw(circle)
	window.draw(polygon)
	window.draw(star)
	window.draw(rounded_rect)
	window.display()
