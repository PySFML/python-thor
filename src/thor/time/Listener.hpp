/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#ifndef PYTHOR_TIME_LISTENER_HPP
#define PYTHOR_TIME_LISTENER_HPP

#include "Python.h"
//#include <Thor/Input/Connection.hpp>
#include <Thor/Time/CallbackTimer.hpp>

struct Listener
{
    Listener(PyObject* object, PyObject* timer);

    void operator() (thor::CallbackTimer& callbackTimer);

    PyObject* object;
    PyObject* timer;
};

void connectListener(thor::CallbackTimer* callbackTimer, PyObject* listener, PyObject* timer);

#endif // PYTHOR_TIME_LISTENER_HPP
