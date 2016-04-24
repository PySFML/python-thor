from sfml cimport Vector2f, Color, Shape, ConvexShape

cdef extern from "Thor/Shapes.hpp" namespace "thor::Shapes":

    ConvexShape toConvexShape(const Shape&)

    ConvexShape line(Vector2f, const Color&)
    ConvexShape line(Vector2f, const Color&, float)

    ConvexShape roundedRect(Vector2f, float, const Color&)
    ConvexShape roundedRect(Vector2f, float, const Color&, float)
    ConvexShape roundedRect(Vector2f, float, const Color&, float, const Color&)

    ConvexShape polygon(size_t, float, const Color&)
    ConvexShape polygon(size_t, float, const Color&, float)
    ConvexShape polygon(size_t, float, const Color&, float, const Color&)

    ConvexShape star(size_t, float, float, const Color&)
    ConvexShape star(size_t, float, float, const Color&, float)
    ConvexShape star(size_t, float, float, const Color&, float, const Color&)
