/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#include "Rule.hpp"

Rule::Rule()
: m_object(NULL)
{
}

Rule::Rule(PyObject* object)
: m_object(object)
{
    Py_XINCREF(m_object);
}

Rule::~Rule()
{
    Py_XDECREF(m_object);
}

PyObject* Rule::get()
{
    Py_XINCREF(m_object);
    return m_object;
}

void Rule::set(PyObject* object)
{
    if (m_object)
        Py_DECREF(m_object);

    m_object = object;
    Py_INCREF(m_object);
}
