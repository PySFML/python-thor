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

#include "particles/DerivableEmitter.hpp"
#include <pysfml/system_api.h>
#include "pythor/particles_api.h"

struct D {
    void operator()(DerivableEmitter* emitter) const {
        Py_DECREF(emitter->object);
        delete emitter;
    }
};

thor::Emitter::Ptr DerivableEmitter::create(PyObject* object)
{
	auto shared_ptr = std::shared_ptr<DerivableEmitter>(new DerivableEmitter(object), D());
	return std::static_pointer_cast<thor::Emitter>(shared_ptr);
}

DerivableEmitter::DerivableEmitter(PyObject* object):
thor::Emitter (),
object        (object)
{
	Py_INCREF(object);

	import_sfml__system();
	import_thor__particles();
}

void DerivableEmitter::emit(thor::Emitter::Adder &system, sf::Time dt)
{
	static char method[] = "emit";
    static char format[] = "(O, O)";

	PyObject* system_object = (PyObject*)(wrap_emitteradder(&system));
	PyObject* dt_object = (PyObject*)(wrap_time(&dt));

    PyObject_CallMethod(object, method, format, system_object, dt_object);
}
