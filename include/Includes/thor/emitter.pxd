from libcpp.thor cimport shared_ptr
from libcpp.thor cimport Emitter
from libcpp.thor cimport Particle

cdef extern from "Thor/Particles.hpp" namespace "thor::Emitter":
	ctypedef shared_ptr[Emitter] Ptr

	cdef cppclass Adder:
		void addParticle(Particle&)
