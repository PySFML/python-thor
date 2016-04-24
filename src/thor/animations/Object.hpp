/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#ifndef PYTHOR_ANIMATIONS_OBJECT_HPP
#define PYTHOR_ANIMATIONS_OBJECT_HPP

#include "Python.h"

class Object
{
public:
    Object();
    Object(PyObject* object);
    ~Object();

    PyObject* get();
    void set(PyObject* object);

private:
    PyObject* m_object;
};

#endif // PYTHOR_ANIMATIONS_OBJECT_HPP
