from libcpp.thor cimport shared_ptr
from libcpp.thor cimport UniversalEmitter

cdef extern from "Thor/Particles.hpp" namespace "thor::UniversalEmitter":
	ctypedef shared_ptr[UniversalEmitter] Ptr
	Ptr create()
