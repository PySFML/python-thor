/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#include "Triangulation.hpp"
#include <Thor/Math.hpp>
#include "math_api.h"
#include "TriangulationTraits.hpp"

PyObject* Py_triangulate(PyObject* listOfVertices)
{
    import_thor__math();

    std::vector<PyObject*> vertices;
    std::vector<thor::Triangle<PyObject*>> triangles;

    Py_ssize_t vertexCount = PyList_Size(listOfVertices);

    for (Py_ssize_t i = 0; i < vertexCount; i++)
    {
            PyObject* vertex = PyList_GetItem(listOfVertices, i);
            vertices.push_back(vertex);
    }

    thor::triangulate(vertices.begin(), vertices.end(), std::back_inserter(triangles));

    PyObject* pytriangles = PyList_New(0);

    for (auto& triangle : triangles)
    {
        PyList_Append(pytriangles, create_triangle(triangle[0], triangle[1], triangle[2]));
    }

    return pytriangles;
}

PyObject* Py_triangulateConstrained(PyObject* vertices, PyObject* constrainedEdges)
{
    // fix-me: to be implemented
    return NULL;
}

PyObject* Py_triangulatePolygon(PyObject* vertices)
{
    // fix-me: to be implemented
    return NULL;
}
