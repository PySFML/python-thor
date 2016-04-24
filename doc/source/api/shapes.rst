Shapes
======
There isn't any complete documentation or API reference for the
shapes module of pyThor yet. Everything below is just quick notes. You'll
also find numerous piece of code to understand how to use this module.

In general, features translate trivially into Python and with the absence
of a complete API reference, you should refer to the C++ documentation to
understand how this module work. Indeed, Python and C++ aren't the same
language and several time, features had to be implemented differently or
simply omitted. This is where this incomplete documention comes in handy
because it lists the things you should know to fill that gap.

Below, you'll find various developer notes. Unless you want to hack the
source code, it's unlikely that they are relevant to you. Please, ignore
them; I had to store them somewhere.

The concave shape
-----------------
The Thor library provides the ConcaveShape class which has the exact
same interface in the SFML library. In pyThor, the ConcaveShape has the
exact same interface as in pySFML. ::

    shape = th.ConcaveShape()

    shape.point_count = 5

    for i in range(shape.point_count):
        shape.set_point(i, (x, y))
        print(shape.get_point(i))

    shape.fill_color = sf.Color.YELLOW
    shape.outline_color = sf.Color.GREEN
    shape.outline_thickness = 5

    print(shape.local_bounds)
    print(shape.global_bounds)

Other custom shapes
-------------------
The Thor library also features custom shapes; one Arrow class and
4 functions returning convex shapes.

Here is how to use the `Arrow` class. ::

    # before using constructing an arrow, you can set the zero vector tolerance
    th.Arrow.set_zero_vector_tolerance(0.2)

    # the tolerance can be read back with
    zero_vector_tolerance = th.Arrow.get_zero_vector_tolerance()

    # create an arrow
    arrow = th.Arrow()

    # modify its properties
    arrow.direction = (400, 350)
    arrow.color = sf.Color.RED
    arrow.thickness = 25

    # the two style are th.Arrow.FORWARD and th.Arrow.LINE
    arrow.style = th.Arrow.FORWARD

With the four functions, you can create lines, rounded rectangle,
regular polygons and stars. They are all in the `th.Shapes` class. ::

    line         = th.Shapes.line((250, 250), sf.Color.RED, 10)
    rounded_rect = th.Shapes.rounded_rect((350, 200), 25, sf.Color.GREEN, 5, sf.Color.YELLOW)
    polygon      = th.Shapes.polygon(12, 250, sf.Color.GREEN, 5, sf.Color.CYAN)
    star         = th.Shapes.star(8, 80, 150, sf.Color.CYAN, 5, sf.Color.YELLOW)

Refer to the Thor documentation in C++ to understand the accepted parameters.

Converting SFML shapes to convex shapes
---------------------------------------
Last thing to know about the shapes module is that function that convert
SFML shapes into convex shapes. Pass either a circle, a rectangle or any
of your custom shapes that subclass the `sf.Shape` and you'll get back
the `sf.ConvexShape` version of it. ::

    rectangle_convexshape = th.Shapes.to_convexshape(sf.RectangleShape((200, 200)))
    circle_convexshape = th.Shapes.to_convexshape(sf.CircleShape(50, 50))

Developers notes
----------------
1) Except that I didn't know if I should implement a submodule for the
stuff in in `thor::Shapes` namespace, everything could be implemented in a
straighyt forward and satisfying way.
