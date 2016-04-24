/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#ifndef PYTHOR_MATH_RULE_HPP
#define PYTHOR_MATH_RULE_HPP

#include "Python.h"

class Rule
{
public:
    Rule();
    Rule(PyObject* object);
    ~Rule();

    PyObject* get();
    void set(PyObject* object);

private:
    PyObject* m_object;
};

#endif // PYTHOR_MATH_RULE_HPP
