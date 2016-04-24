from sfml import sf
from thor import th

# finds out whether a vertex is near a given position
def remove_vertex(vertices, position):

	# find out which point was clicked on (tolerance radius is 6 pixels, as big as the circle's radius)
    for vertex in vertices:
        if th.squared_length(position - vertex) <= 36:
            vertices.remove(vertex)
            return True

    return False

# handles clicks on a vertex; returns true if a new triangulation is required
def handle_vertex_click(mouse_event, vertices):
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
    elif mouse_event.button == sf.Mouse.RIGHT:
        if (remove_vertex(vertices, click_pos)):
            return True

    return False

# handles SFML events; returns false if the application should be quit
def handle_events(window, vertices, triangles):

    for event in window.events:
        # mouse buttons: add or remove vertex
        if event == sf.MouseButtonEvent and event.pressed:

            # compute new triangulation for points if necessary
            if handle_vertex_click(event, vertices):
                triangles[:] = th.triangulate(vertices)

        # keys (C -> clear, Esc -> quit)
        elif event == sf.KeyEvent and event.pressed:
            if event.code == sf.Keyboard.ESCAPE:
                return False

            if event.code == sf.Keyboard.C:
                vertices.clear()
                triangles.clear()

        elif event == sf.CloseEvent:
            return False

    return True

# create render window
window = sf.RenderWindow(sf.VideoMode(640, 480), "Thor - Triangulation", sf.Style.CLOSE)
window.framerate_limit = 20

# create containers in which we store the vertices and the computed triangles
vertices = []
triangles = []

font = sf.Font.from_file("Media/sansation.ttf")

# description with instructions
instructions_text = "Left click to add point\n"
instructions_text += "Right click to remove point\n"
instructions_text += "C key to clear everything"
instructions = sf.Text(instructions_text, font, 14)

# main loop
running = True

while running:

    # event handling, possible quit
    if not handle_events(window, vertices, triangles):
        running = True

    # clear background
    window.clear()

    # draw all triangles
    for triangle in triangles:
        shape = sf.ConvexShape()
        shape.point_count = 3
        shape.fill_color = sf.Color(0, 150, 255, 100)
        shape.outline_color = sf.Color.BLUE
        shape.outline_thickness = 5

        for i in range(3):
            shape.set_point(i, triangle[i])

        window.draw(shape)

    # draw all points
    for vertex in vertices:
        circle = sf.CircleShape()
        circle.position = vertex - (6, 6)
        circle.radius = 6
        circle.fill_color = sf.Color(255, 0, 150)

        window.draw(circle)

    # draw description and update screen
    window.draw(instructions)
    window.display()
