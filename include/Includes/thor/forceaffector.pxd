from libcpp.sfml cimport Vector2f
from libcpp.thor cimport shared_ptr
from libcpp.thor cimport ForceAffector

cdef extern from "Thor/Particles.hpp" namespace "thor::ForceAffector":
	ctypedef shared_ptr[ForceAffector] Ptr
	Ptr create(Vector2f)
