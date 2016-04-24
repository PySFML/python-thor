from libcpp.thor cimport shared_ptr
from libcpp.thor cimport Affector

cdef extern from "Thor/Particles.hpp" namespace "thor::Affector":
	ctypedef shared_ptr[Affector] Ptr
