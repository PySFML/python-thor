/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#ifndef PYTHOR_MATH_TRIANGULATION_HPP
#define PYTHOR_MATH_TRIANGULATION_HPP

#include "Python.h"

PyObject* Py_triangulate(PyObject* vertices);
PyObject* Py_triangulateConstrained(PyObject* vertices, PyObject* constrainedEdges);
PyObject* Py_triangulatePolygon(PyObject* vertices);

#endif // PYTHOR_MATH_TRIANGULATION_HPP
