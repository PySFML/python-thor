cdef extern from "Thor/Input.hpp" namespace "thor::Action":

    cdef enum ActionType:
        Hold
        PressOnce
        ReleaseOnce
