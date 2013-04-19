////////////////////////////////////////////////////////////////////////////////
//
// pyThor - Python bindings for Thor
// Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//
// This software is released under the LGPLv3 license.
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////


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
