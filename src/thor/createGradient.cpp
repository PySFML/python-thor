//------------------------------------------------------------------------------
// PyThor - Python bindings for Thor
// Copyright (c) 2013-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
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

#include "createGradient.hpp"
#include "Thor/Graphics.hpp"
#include <SFML/Graphics.hpp>
#include "pysfml/graphics_api.h"
#include "pysfml/graphics.h"
#include "pythor/graphics_api.h"
#include "pythor/graphics.h"

PyObject* createGradientFromList(PyObject* list)
{
	// the following code assumes the list content has been checked before
	import_thor__graphics();

	Py_ssize_t i, n;
    n = PyList_Size(list);

    if (n < 0)
        return NULL;

	PyColorObject* color = (PyColorObject*)PyList_GetItem(list, 0);

	thor::detail::ColorGradientConvertible temp_conv = thor::createGradient(*color->p_this);
	thor::detail::ColorGradientTransition* temp_trans;

	PyColorObject* tempColor   = NULL;
	float tempInteger = 0;

    bool isColor = false;

    for (i = 1; i < n; i++)
    {

		if (isColor)
		{
			tempColor = (PyColorObject*)PyList_GetItem(list, i);
			temp_conv = (*temp_trans)(*tempColor->p_this);
		}
		else
		{
			tempInteger = PyFloat_AsDouble(PyList_GetItem(list, i));
			temp_trans = &temp_conv(tempInteger);
		}

        isColor = !isColor;
	}

	thor::ColorGradient* finalColor = new thor::ColorGradient(temp_conv);
	return wrap_colorgradient(finalColor);
}
