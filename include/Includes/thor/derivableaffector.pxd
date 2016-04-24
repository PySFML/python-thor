from libcpp.thor cimport affector
#from dparticles cimport shared_ptr
#from dparticles cimport DerivableAffector

cdef extern from "particles/DerivableAffector.hpp" namespace "DerivableAffector":
	#ctypedef shared_ptr[DerivableAffector] Ptr
	affector.Ptr create(object)
	#shared_ptr[DerivableAffector] create(object)
