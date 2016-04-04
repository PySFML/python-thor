//------------------------------------------------------------------------------
// PySFML - Python bindings for Thor
// Copyright (c) 2012-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from the
// use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software in a
//    product, an acknowledgment in the product documentation would be
//    appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such, and must not be
//    misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.
//------------------------------------------------------------------------------

#include "pythor/TrigonometricTraits.hpp"

namespace thor
{
static void initialize()
{
    //PyObject* mathModule = PyImport_ImportModule("math");
}

static NumericObject sin(NumericObject deg)
{
    //PyObject* mathModule = PyImport_ImportModule("math");
    //PyObject* sinMethod = PyObject_GetAttrString(mathModule, "sin");
    //PyObject* result = PyObject_CallFunction(sinMethod, deg.m_object);

    //return NumericObject(result);

    return 0;
}

static NumericObject cos(NumericObject deg)
{
    //PyObject* mathModule = PyImport_ImportModule("math");
    //PyObject* cosMethod = PyObject_GetAttrString(mathModule, "cos");
    //PyObject* result = PyObject_CallFunction(cosMethod, deg.m_object);

    //return NumericObject(result);

    return 0;
}

static NumericObject tan(NumericObject deg)
{
    //PyObject* mathModule = PyImport_ImportModule("math");
    //PyObject* tanMethod = PyObject_GetAttrString(mathModule, "tan");
    //PyObject* result = PyObject_CallFunction(tanMethod, deg.m_object);

    //return NumericObject(result);

    return 0;
}
static NumericObject arcSin(NumericObject value)
{
    //PyObject* mathModule = PyImport_ImportModule("math");
    //PyObject* arcSinMethod = PyObject_GetAttrString(mathModule, "arcSin");
    //PyObject* result = PyObject_CallFunction(arcSinMethod, value.m_object);

    //return NumericObject(result);

    return 0;
}

static NumericObject arcCos(NumericObject value)
{
    //PyObject* mathModule = PyImport_ImportModule("math");
    //PyObject* arcCosMethod = PyObject_GetAttrString(mathModule, "arcCos");
    //PyObject* result = PyObject_CallFunction(arcCosMethod, value.m_object);

    //return NumericObject(result);

    return 0;
}

static NumericObject arcTan2(NumericObject valY, NumericObject valX)
{
    //PyObject* mathModule = PyImport_ImportModule("math");
    //PyObject* arcTan2Method = PyObject_GetAttrString(mathModule, "arcTan2");
    //PyObject* result = PyObject_CallFunction(arcTan2Method, deg.m_object);

    //return NumericObject(result);

    return 0;
}

static NumericObject sqrt(NumericObject value)
{
    return 0;
}

static NumericObject pi()
{
    return 0;
}

static NumericObject radToDeg(NumericObject rad)
{
    return 0;
}

static NumericObject degToRad(NumericObject deg)
{
    return 0;
}
} // namespace thor

static void initialize()
{
    thor::TrigonometricTraits<NumericObject>::initialize();
}
