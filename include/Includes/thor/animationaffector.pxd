from libcpp.thor cimport FrameAnimation, ColorAnimation, FadeAnimation
from libcpp.thor cimport shared_ptr
from libcpp.thor cimport AnimationAffector

cdef extern from "Thor/Particles.hpp" namespace "thor::AnimationAffector":
	ctypedef shared_ptr[AnimationAffector] Ptr
	Ptr create(ColorAnimation)
	Ptr create(FadeAnimation)
