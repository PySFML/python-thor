Todo list
=========
As I mentioned, these bindings are works-in-progress.
Here are some notes, but there's nothing exhaustive.
Trying to summarizes notes, everything we should be aware of when using Thor.

.. contents:: :local:

General Notes
-------------
* May have some memory leaks

Distribution API allows: ::

   particle_lifetime = sf.seconds(5)
   particle_lifetime = lambda: blabla return sf.Time
   particle_lifetime = th.Distribution(sf.Time)
   particle_lifetime = th.Distribution(functor returning sf.Time)

while in C++, that would be: ::

   setParticleLifeTime(sf::seconds(5))
   setParticleLifeTime(functor returning sf::Time)
   setParticleLifeTime(th::Distribution(sf::seconds(5)))
   setParticleLifeTime(th::Distribution(functor returning sf::Time))


* toString functions not implemented because it can achieved using str(object).

The question is what standard should we use to represent object (as a string).
toString(color) and str(color) wouldn't return the same string :/

* Move Distribution stuff to a submodule or create a namespace
* Same for shapes

Examples implementation progress:

.. raw:: html

   <font color="green">animation.py</font><br />
   <font color="green">shapes.py</font><br />
   <font color="green">time.py</font><br />
   <font color="orange">triangulation.py</font><br />
   <font color="green">particles.py</font><br />
   <font color="red">action.py</font><br />
   <font color="green">fireworks.py</font><br />
   <font color="red">user_events.py</font><br />
   <font color="red">resources.py</font><br />


Graphics Module
---------------
.. raw:: html

   <font color="green">Minimal tests have been perfomed. This module is complete!</font>

* Function setAlpha(T) won't be implemented
* Function setColor(T) won't be implemented
* Print the actual error message when thor.graphics.BigTexture fails to load
* Functions toString(T) won't be implemented (`StringConversionException` neither)
* **Improve ColorGradiet interface** [#]_
* Insert assertions to make sure the list of colors is well formed [#]_

.. [#] Unlike in C++, you construct gradient colors from list of color and integers.
.. [#] Otherwise the C++ function `createGradientFromColor` will fail.

Math Module
-----------
.. raw:: html

   <font color="red">No tests have been perfomed. This module is NOT complete!</font>

- Implement an stl iterator to iterate over Python list
- Improve triangulation function (segmentation fault when passing wrong values)
- Figure out how TriangulationTrait<T> works
- triangulation_constrained not implemented yet
- triangulation_polygon not implemented yet

Particule Module
----------------
.. raw:: html

   <font color="green">Minimal tests have been perfomed. This module is complete!</font>

- Find out how to share texture in ParticleSystem (issue #1)
- Allow using a Python function to animate a particle
- Move AnimationAffector.create to Animation.__init__ once bug in Cython is fixed
A current bug prevent fused type from being used in Python constructors, so I
made the constructor a classmethod.


Shapes Module
-------------
.. raw:: html

   <font color="green">Minimal tests have been perfomed. This module is complete!</font>

* Move shapes to their own namespace or create a submodule

Animation Module
---------------
.. raw:: html

   <font color="green">Minimal tests have been perfomed. This module is almost complete!</font>

* Allow Python functor in Animator.add_animation
* Allow Animator to animate any Python object (currently designed to animate sprite only)

Time Module
-----------
.. raw:: html

   <font color="green">Minimal tests have been perfomed. This module is complete!</font>

* Be able to write `timer.connect(function, args, kwars)` or `timer.connect(lambda: function(args, kwargs))`

Vectors Module
--------------
.. raw:: html

   <font color="green">Minimal tests have been perfomed. </font>

.. raw:: html

   <font color="red">This module is NOT complete!</font>

* Remove PolarVector2.to_vector2()
* **Add default constructor to PolarVector2**
* Implement `length(Vector2[T]&)`
* Implement `squaredLength(Vector2[T]&)`
* Implement `setLength(Vector2[T]&, T)`
* Implement `unitVector(Vector2[T]&)`
* Implement `polarAngle(Vector2[T]&)`
* Implement `setPolarAngle(Vector2[T]&, T)`
* Implement `rotate(Vector2[T]&, T)`
* Implement `rotatedVector(Vector2[T]&, T)`
* Implement `perpendicularVector(Vector2[T]&)`
* Implement `signedAngle(Vector2[T]&, Vector2[T]&)`
* Implement `dotProduct(Vector2[T]&, Vector2[T]&)`
* Implement `crossProduct(Vector2[T]&, Vector2[T]&)`
* Implement `componentwiseProduct(Vector2[T]&, Vector2[T]&)`
* Implement `componentwiseQuotient(Vector2[T]&, Vector2[T]&)`
* Implement `length(Vector3[T]&)`
* Implement `squaredLength(Vector3[T]&)`
* Implement `unitVector(Vector3[T]&)`
* Implement `polarAngle(Vector3[T]&)`
* Implement `elevationAngle(Vector3[T]&)`
* Implement `dotProduct(Vector3[T]&, Vector3[T]&)`
* Implement `crossProduct(Vector3[T]&, Vector3[T]&)`
* Implement `componentwiseProduct(Vector3[T]&, Vector3[T]&)`
* Implement `componentwiseQuotient(Vector3[T]&, Vector3[T]&)`
* Implement `toVector3(Vector2[T]&)`
