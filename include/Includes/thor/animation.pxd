cimport danimation

cdef extern from "animation.h":
	cdef class thor.animation.FrameAnimation [object PyFrameAnimationObject]:
		cdef danimation.FrameAnimation *p_this

	cdef class thor.animation.ColorAnimation [object PyColorAnimationObject]:
		cdef danimation.ColorAnimation *p_this

	cdef class thor.animation.FadeAnimation [object PyFadeAnimationObject]:
		cdef danimation.FadeAnimation *p_this
