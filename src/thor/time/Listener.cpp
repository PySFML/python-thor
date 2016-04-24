/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#include "Listener.hpp"

Listener::Listener(PyObject* object, PyObject* timer)
: object(object)
, timer(timer)
{
    Py_INCREF(object);
}

void Listener::operator()(thor::CallbackTimer& callbackTimer)
{
    PyObject* result = PyObject_CallFunctionObjArgs(object, timer);

    if (!result)
            PyErr_Print();
}

void connectListener(thor::CallbackTimer* callbackTimer, PyObject* listener, PyObject* caller)
{
    callbackTimer->connect(Listener(listener, caller));
}
