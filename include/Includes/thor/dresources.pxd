cdef extern from "Thor/Resources.hpp" namespace "thor::Resources":

    cdef struct CentralOwner:
        pass

    cdef struct RefCounted:
        pass

    cdef enum KnownIdStrategy:
        AssumeNew
        Reuse
        Reload
