from libcpp.thor cimport emitter

cdef extern from "particles/DerivableEmitter.hpp" namespace "DerivableEmitter":
	emitter.Ptr create(object)
