from libcpp.thor cimport shared_ptr
from libcpp.thor cimport TorqueAffector

cdef extern from "Thor/Particles.hpp" namespace "thor::TorqueAffector":
	ctypedef shared_ptr[TorqueAffector] Ptr
	Ptr create(float)
