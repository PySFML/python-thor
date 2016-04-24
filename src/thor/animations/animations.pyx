#
# PyThor - Python bindings for Thor
# Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#

"""
    Classes able to animate graphical objects in different ways.
"""
# todo:
# - fix test variables
# - implement GradientColor to implement ColorAnimation
# - implement tests
# - make sure exceptions are raised
# - remove useless import_system/graphics statements
# - improve Animator implementation to have an object as ID template parameter

#__all__ = ['ColorAnimation', 'FadeAnimation', 'FrameAnimation', 'Animator']
__all__ = ['FadeAnimation', 'FrameAnimation', 'Animator']

#from libcpp.string cimport string

cimport sfml as sf
cimport thor as th

from pysfml.system cimport Time, to_vector2f
from pysfml.system cimport import_sfml__system

#from pysfml.graphics cimport ColorGradient, to_intrect
from pysfml.graphics cimport to_intrect
from pysfml.graphics cimport import_sfml__graphics

cdef extern from "Object.hpp":
    cdef cppclass Object:
        Object()
        Object(object)

        object get()
        void set(object)

import_sfml__system()
import_sfml__graphics()

#cdef public class ColorAnimation[type PyColorAnimationType, object PyColorAnimationObject]:
#   cdef th.ColorAnimation *p_this

#   def __cinit__(self, ColorGradient gradient):
#       self.p_this = new th.ColorAnimation(gradient.p_this[0])

#   def __dealloc__(self):
#       del self.p_this

cdef public class FadeAnimation[type PyFadeAnimationType, object PyFadeAnimationObject]:
    cdef th.FadeAnimation *p_this

    def __cinit__(self, float in_ratio, float out_ratio):
        self.p_this = new th.FadeAnimation(in_ratio, out_ratio)

    def __dealloc__(self):
        del self.p_this

    def __call__(self, animated, progress):
        cdef th.ColorizableObject* test = new th.ColorizableObject(animated)
        self.p_this[0](test[0], progress)
        del test

cdef public class FrameAnimation[type PyFrameAnimationType, object PyFrameAnimationObject]:
    cdef th.FrameAnimation *p_this

    def __cinit__(self):
        self.p_this = new th.FrameAnimation()

    def __dealloc__(self):
        del self.p_this

    def __call__(self, animated, progress):
        cdef th.FramableObject* test = new th.FramableObject(animated)
        self.p_this[0](test[0], progress)
        del test

    def add_frame(self, float relative_duration, subrect, origin=None):
        if not origin:
            self.p_this.addFrame(relative_duration, to_intrect(subrect))
        else:
            self.p_this.addFrame(relative_duration, to_intrect(subrect), to_vector2f(origin))

cdef class Animator:
    cdef th.Animator[Object, int] *p_this

    def __cinit__(self):
        self.p_this = new th.Animator[Object, int]()

    def __dealloc__(self):
        del self.p_this

    def add_animation(self, int id_, animation, Time duration):
        self.p_this.addAnimation(id_, th.AnimationFunction(animation), duration.p_this[0])

    def play_animation(self, int id_, bint loop=False):
        self.p_this.playAnimation(id_, loop)

    def stop_animation(self):
        self.p_this.stopAnimation()

    def is_playing_animation(self):
        return self.p_this.isPlayingAnimation()

    def get_playing_animation(self):
        return self.p_this.getPlayingAnimation()

    def update(self, Time dt):
        self.p_this.update(dt.p_this[0])

    def animate(self, animated):
        cdef Object* test = new Object(animated)
        self.p_this.animate(test[0])
        del test
