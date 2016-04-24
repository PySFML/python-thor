from random import randint
from sfml import sf
from thor import th

window = sf.RenderWindow(sf.VideoMode(640, 480), "")

# Test arrow
arrow = th.Arrow()

print(arrow.position)
arrow.position = (50, 50)
print(arrow.position)

print(arrow.direction)
arrow.direction = (400, 350)
print(arrow.direction)

print(arrow.color)
arrow.color = sf.Color.RED
print(arrow.color)

print(arrow.thickness)
arrow.thickness = 25
print(arrow.thickness)

print(arrow.style)
arrow.style = th.Arrow.FORWARD
print(arrow.style)

print(th.Arrow.get_zero_vector_tolerance())
th.Arrow.set_zero_vector_tolerance(0.2)
print(th.Arrow.get_zero_vector_tolerance())

window.clear()
window.draw(arrow)
window.display()

input("Press enter to continue the testing")

# Test concaveshape
shape = th.ConcaveShape()

print(shape.point_count)
shape.point_count = 5
print(shape.point_count)

for i in range(shape.point_count):
    print("point {0}: {1}".format(i, shape.get_point(i)))

for i in range(shape.point_count):
    shape.set_point(i, (randint(0, 500), randint(0, 400)))

for i in range(shape.point_count):
    print("point {0}: {1}".format(i, shape.get_point(i)))

print(shape.fill_color)
shape.fill_color = sf.Color.YELLOW
print(shape.fill_color)

print(shape.outline_color)
shape.outline_color = sf.Color.GREEN
print(shape.outline_color)

print(shape.outline_thickness)
shape.outline_thickness = 5
print(shape.outline_thickness)

print(shape.local_bounds)
print(shape.global_bounds)

window.clear()
window.draw(shape)
window.display()

input("Press enter to continue the testing")

# Test constructing ConcaveShape from regular shape
circle_shape = sf.CircleShape(50, 50)
shape2 = th.ConcaveShape.from_shape(circle_shape)
print(shape2)

window.clear()
window.draw(shape2)
window.display()

input("Press enter to continue the testing")

# Test line
line = th.Shapes.line((250, 250), sf.Color.RED)
line = th.Shapes.line((250, 250), sf.Color.RED, 10)

window.clear()
window.draw(line)
window.display()

input("Press enter to continue the testing")

# Test rounded_rect
rounded_rect = th.Shapes.rounded_rect((350, 200), 25, sf.Color.GREEN)
rounded_rect = th.Shapes.rounded_rect((350, 200), 25, sf.Color.GREEN, 5)
rounded_rect = th.Shapes.rounded_rect((350, 200), 25, sf.Color.GREEN, 5, sf.Color.YELLOW)

rounded_rect.position = (100, 100)

window.clear()
window.draw(rounded_rect)
window.display()

input("Press enter to continue the testing")

# Test polygon
polygon = th.Shapes.polygon(12, 250, sf.Color.GREEN, 5)
polygon = th.Shapes.polygon(12, 250, sf.Color.GREEN, 5, sf.Color.CYAN)

polygon.position = (350, 350)

window.clear()
window.draw(polygon)
window.display()

input("Press enter to continue the testing")

# Test star
star = th.Shapes.star(8, 80, 150, sf.Color.CYAN)
star = th.Shapes.star(8, 80, 150, sf.Color.CYAN, 5)
star = th.Shapes.star(8, 80, 150, sf.Color.CYAN, 5, sf.Color.YELLOW)

star.position = (300, 300)

window.clear()
window.draw(star)
window.display()

input("Press enter to continue the testing")

# Test converting to convexshape
rectangle_convexshape = th.Shapes.to_convexshape(sf.RectangleShape((200, 200)))
circle_convexshape = th.Shapes.to_convexshape(sf.CircleShape(50, 50))

print(rectangle_convexshape)
print(circle_convexshape)

window.clear()
window.draw(rectangle_convexshape)
window.draw(circle_convexshape)
window.display()

input("Press enter to continue the testing")
