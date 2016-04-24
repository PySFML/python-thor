from libcpp.sfml cimport Vector2f
from libcpp.thor cimport shared_ptr
from libcpp.thor cimport ScaleAffector

cdef extern from "Thor/Particles.hpp" namespace "thor::ScaleAffector":
	ctypedef shared_ptr[ScaleAffector] Ptr
	Ptr create(Vector2f)
