Vectors
=======
There isn't any complete documentation or API reference for the
vectors module of pyThor yet. Everything below is just quick notes. You'll
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

Polar vectors
-------------
PolarVector2 works pretty much just like sf.Vector2. Have a look at the
following snipped of code to understand what you can do with it. ::

    from thor import th

    # create a vector from a radius and a angle
    polar_vector = th.PolarVector2(5, 36)

    # print out the radius and the angle
    print(polar_vector.r)   # display 5
    print(polar_vector.phi) # display 36

    # you can copy polar vectors
    copy_polar_vector = copy(polar_vector)

    # ... and unpack them
    r, phi = copy_polar_vector

    # you can also convert them to sf.Vector2 this way
    vector2_version = polar_vector.to_vector2()

    # or this way...
    vector2_version_bis = th.PolarVector2.to_vector2(polar_vector)

**Warning**: `th.PolarVector2.to_vector2` results in segfault. This is
a known bug. Feel free to fix the bug yourself.

Operations based on vectors
---------------------------
The vector module of Thor library provides a plethora of functions
manipulating vectors. All of them are implemented in pyThor. ::

    # create a few vector to work with
    polar_vector = th.PolarVector2(1, 2)
    vector2 = sf.Vector2(1, 2)
    vector3 = sf.Vector3(1, 2, 3)

    th.length(polar_vector)
    th.length(vector2)
    th.length(vector3)

    th.squared_length(vector2)
    th.squared_length(vector3)

    th.set_length(vector2, 50)

    th.unit_vector(vector2) # buggy
    th.unit_vector(vector3) # buggy

    th.polar_angle(polar_vector)
    th.polar_angle(vector2)
    th.polar_angle(vector3)

    th.set_polar_angle(vector2, 50)

    th.rotate(vector2, 35)

    th.rotated_vector(vector2, 35) # buggy

    th.perpendicular_vector(vector2) # buggy

    th.signed_angle(sf.Vector2(1, 2), sf.Vector2(3, 4))

    th.dot_product(sf.Vector2(1, 2), sf.Vector2(3, 4))
    th.dot_product(sf.Vector3(1, 2, 3), sf.Vector3(4, 5, 6))

    th.cross_product(sf.Vector2(1, 2), sf.Vector2(3, 4))
    th.cross_product(sf.Vector3(1, 2, 3), sf.Vector3(4, 5, 6)) # buggy

    th.cwise_product(sf.Vector2(1, 2), sf.Vector2(3, 4)) # buggy
    th.cwise_product(sf.Vector3(1, 2, 3), sf.Vector3(4, 5, 6)) # buggy

    th.cwise_quotient(sf.Vector2(1, 2), sf.Vector2(3, 4)) # buggy
    th.cwise_quotient(sf.Vector3(1, 2, 3), sf.Vector3(4, 5, 6)) # buggy

    th.projected_vector(sf.Vector2(1, 2), sf.Vector2(3, 4)) # buggy

    th.elevation_angle(vector3)

    th.to_vector3(vector2)

**Warning**: Because of a bug that appears when wrapping sf::Vector2 and
sf::Vector3, a few of them fail. Once this bug is fixed, they should all
work properly.

Developers notes
----------------

1) Because PolarVector2 has tight integration with Vector2, they need to
hold the same object type (NumericObject). This is particularly needed
for operator sf::Vector2<T> () operator to work.

2) The trigonometric traits had to be specialized for NumericObject in
the math module. Almost all functions in the vectors module are likely
to fail if a bug is found in the specilization implementation.
