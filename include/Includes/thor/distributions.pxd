from sfml cimport Vector2f, Time
from thor cimport Distribution

cdef extern from "Thor/Math.hpp" namespace "thor::Distributions":
    Distribution[int] uniform(int, int)
    Distribution[unsigned int] uniform(unsigned int, unsigned int)
    Distribution[float] uniform(float, float)
    Distribution[Time]  uniform(Time, Time)
    Distribution[Vector2f] rect(Vector2f, Vector2f)
    Distribution[Vector2f] circle(Vector2f, float)
    Distribution[Vector2f] deflect(Vector2f, float)
