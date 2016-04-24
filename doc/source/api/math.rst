Math
====
There isn't any complete documentation or API reference for the
math module of pyThor yet. Everything below is just quick notes. You'll
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

Randomize and Mathematics utilities
-----------------------------------
About randomization utilities, nothing much change in Python ::

    from thor import th

    th.set_random_seed(seed) # seed is an int

    th.random(min_, max_) # works with any numeric
    th.random_dev(middle, deviation) # work with float

Thor provides the PI constant with two converting function; they are
exposed to Python as well. ::

    from thor import th

    print(th.PI) # display 3.14xxx

    radian = th.to_radian(degree)
    degree = th.to_degree(radian)

Note that using `th.to_radian` result in calling internally `math.radians` from the
math module from the Python standard library. The same for `th.to_degree`

TODO: answer that question ::

    why would we implement PI and converting function when you can find
    them in the Python Standard library ? *Answer:* it has to do with
    trigonometric traits


Distributions features
----------------------
You can construct a Distribution function with a regular Python function
Note that constructing a Distribution with *a constant* is *not* supported yet
But you can work around it by implementing a functor that returns a constant. ::

    from random import randint

    def multiple_of_42():
        return 42 * randint(10)

    distribution = th.Distribution(multiple_of_42)

    # display 10 random multiple of  42
    for _ in range(10):
        print(distribution())

You'll need to use distributions troughout all pyThor module just like
in the original API, such as in the Particles module to randomize particules
effects.

The static methods found in the `thor::Distributions` namespace are
implemented in the `thor.math.Distributions` class. ::

    import thor.math

    uniform_distribution = thor.math.Distributions.uniform(min_, max_) # min_ and max_ could be int, float or Time
    rect_distribution = thor.math.Distributions.rect(center, half_size)
    circle_distribution = thor.math.Distributions.circle(center, radius)
    deflect_distribution(direction, max_rotation)

Refer to the C++ documentation to understand the type of each arguments.

Triangulations features
-----------------------
In Thor library, three triangulation algorithms are provided. So far,
only `triangulate` is implemented. ::

    triangulate(vertices)
    triangulate_constrained(vertices, constrained_edges) # not implemented yet!
    triangulate_polygon(vertices)                        # not implemented yet!

The function `triangulate` expects any variable that can be transformed
into a list of vertices with `list(vertices)`. Refer to the example
"triangulation.py" to have a working example of this function.

Developers notes
----------------
1) In the implemetnation of Edge and Triangle, I had to book keep the
internal vertices (the corners) because in the C++ API they're only
references existing vertices. If the Python are not kept, then vertices
might be freed up and it would results in segfault.

2) Additionally, the math module contains the trigonometric traits for
NumericObject from pySFML system module. This is needed in thor.vectors
module.
