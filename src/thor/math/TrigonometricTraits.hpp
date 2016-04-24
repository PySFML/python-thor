/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#ifndef PYTHOR_MATH_TRIGONOMETRICTRAITS_HPP
#define PYTHOR_MATH_TRIGONOMETRICTRAITS_HPP

#include <Python.h>
#include <Thor/Math/Trigonometry.hpp>
#include <pysfml/system/NumericObject.hpp>

#include <iostream>

namespace thor
{
template <>
struct TrigonometricTraits<PyObject*>
{
    static PyObject* sin(PyObject* deg) {
        PyObject* module = PyImport_ImportModule("math");
        PyObject* sin = PyObject_GetAttrString(module, "sin");
        return PyObject_CallFunctionObjArgs(sin, deg, NULL);
        };

    static PyObject* cos(PyObject* deg) {
        PyObject* module = PyImport_ImportModule("math");
        PyObject* cos = PyObject_GetAttrString(module, "cos");
        return PyObject_CallFunctionObjArgs(cos, deg, NULL);
        };

    static PyObject* tan(PyObject* deg) {
        std::cout << "tan lol" << std::endl;
        return 0;
        };

    static PyObject* arcSin(PyObject* value) {
        std::cout << "arcSin lol" << std::endl;
        return 0;
        };

    static PyObject* arcCos(PyObject* value) {
        std::cout << "arcCos lol" << std::endl;
        return 0;
        };

    static PyObject* arcTan2(PyObject* valY, PyObject* valX) {
        PyObject* module = PyImport_ImportModule("math");
        PyObject* atan2 = PyObject_GetAttrString(module, "atan2");
        return PyObject_CallFunctionObjArgs(atan2, valY, valX, NULL);
        };

    static PyObject* sqrt(PyObject* value) {
        PyObject* module = PyImport_ImportModule("math");
        PyObject* sqrt = PyObject_GetAttrString(module, "sqrt");
        return PyObject_CallFunctionObjArgs(sqrt, value, NULL);
        };

    static PyObject* pi() {
        std::cout << "pi lol" << std::endl;
        return 0;
        };

    static PyObject* radToDeg(PyObject* rad) {
        PyObject* module = PyImport_ImportModule("math");
        PyObject* degrees = PyObject_GetAttrString(module, "degrees");
        return PyObject_CallFunctionObjArgs(degrees, rad, NULL);
        };

    static PyObject* degToRad(PyObject* deg) {
        PyObject* module = PyImport_ImportModule("math");
        PyObject* radians = PyObject_GetAttrString(module, "radians");
        return PyObject_CallFunctionObjArgs(radians, deg, NULL);
        };
};

template <>
struct TrigonometricTraits<NumericObject>
{
    static PyObject* sin(NumericObject deg) {
        return TrigonometricTraits<PyObject*>::sin(deg.get());
        };

    static PyObject* cos(NumericObject deg) {
        return TrigonometricTraits<PyObject*>::cos(deg.get());
        };

    static PyObject* tan(NumericObject deg) {
        return TrigonometricTraits<PyObject*>::tan(deg.get());
        };

    static PyObject* arcSin(NumericObject value) {
        return TrigonometricTraits<PyObject*>::arcSin(value.get());
        };

    static PyObject* arcCos(NumericObject value) {
        return TrigonometricTraits<PyObject*>::arcCos(value.get());
        };

    static PyObject* arcTan2(NumericObject valY, NumericObject valX) {
        return TrigonometricTraits<PyObject*>::arcTan2(valY.get(), valX.get());
        };

    static PyObject* sqrt(NumericObject value) {
        return TrigonometricTraits<PyObject*>::sqrt(value.get());
        };

    static PyObject* pi() {
        return TrigonometricTraits<PyObject*>::pi();
        };

    static PyObject* radToDeg(NumericObject rad) {
        return TrigonometricTraits<PyObject*>::radToDeg(rad.get());
        };

    static PyObject* degToRad(NumericObject deg) {
        return TrigonometricTraits<PyObject*>::degToRad(deg.get());
    };
};
} // namespace thor

#endif // PYTHOR_MATH_TRIGONOMETRICTRAITS_HPP
