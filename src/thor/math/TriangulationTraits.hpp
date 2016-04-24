/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#ifndef PYTHOR_MATH_TRIANGULATIONTRAITS_HPP
#define PYTHOR_MATH_TRIANGULATIONTRAITS_HPP

#include <Python.h>
#include <Thor/Math/Trigonometry.hpp>

namespace thor
{
template <>
struct TriangulationTraits<PyObject*>
{
    static sf::Vector2f getPosition(PyObject* const vertex)
    {
        // trigger exception if no attrib x and y
        double x = PyFloat_AsDouble(PyObject_GetAttrString(vertex, "x"));
        double y = PyFloat_AsDouble(PyObject_GetAttrString(vertex, "y"));

        return sf::Vector2f(x, y);
    }
};
} // namespace thor


#endif // PYTHOR_MATH_TRIANGULATIONTRAITS_HPP
