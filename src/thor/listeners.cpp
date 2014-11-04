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

#include "listeners.hpp"

struct CallPythonFunction
{
	CallPythonFunction(PyObject* object)
	: object(object)
	{
	}

	void operator()(thor::CallbackTimer&)
	{
		PyGILState_STATE gstate;
		gstate = PyGILState_Ensure();

		PyObject_CallFunctionObjArgs(object, NULL);

		PyGILState_Release(gstate);
	}

	PyObject* object;
};

thor::Connection CallbackTimer_connect(thor::CallbackTimer* timer, PyObject* object)
{
	return timer->connect(CallPythonFunction(object));
}
