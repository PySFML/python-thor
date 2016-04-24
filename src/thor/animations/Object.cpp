/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#include "Object.hpp"

Object::Object()
: m_object(NULL)
{
}

Object::Object(PyObject* object)
: m_object(object)
{
    Py_XINCREF(m_object);
}

Object::~Object()
{
    Py_XDECREF(m_object);
}

PyObject* Object::get()
{
    Py_XINCREF(m_object);
    return m_object;
}

void Object::set(PyObject* object)
{
    if (m_object)
        Py_DECREF(m_object);

    m_object = object;
    Py_INCREF(m_object);
}
