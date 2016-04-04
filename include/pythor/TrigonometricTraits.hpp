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

#ifndef PYTHOR_NUMERICOBJECT_HPP
#define PYTHOR_NUMERICOBJECT_HPP

#include <Python.h>
#include <Thor/Math/Trigonometry.hpp>
#include <SFML/System/NumericObject.hpp>


namespace thor
{
template <>
struct TrigonometricTraits<NumericObject>
{
    //enum FunctionEnum
    //{
        //Sin,
        //Cos,
        //Count
    //};

    static void initialize();

    static NumericObject sin(NumericObject deg);
    static NumericObject cos(NumericObject deg);
    static NumericObject tan(NumericObject deg);

    static NumericObject arcSin(NumericObject value);
    static NumericObject arcCos(NumericObject value);
    static NumericObject arcTan2(NumericObject valY, NumericObject valX);

    static NumericObject sqrt(NumericObject value);

    static NumericObject pi();

    static NumericObject radToDeg(NumericObject rad);
    static NumericObject degToRad(NumericObject deg);

};
} // namespace Thor

void initialize();

#endif // PYTHOR_NUMERICOBJECT_HPP
