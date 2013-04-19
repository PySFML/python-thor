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


#include "particles/DerivableAffector.hpp"
#include <pysfml/system_api.h>
#include "pythor/particles_api.h"


struct D {
    void operator()(DerivableAffector* affector) const {
        Py_DECREF(affector->object);
        delete affector;
    }
};

thor::Affector::Ptr DerivableAffector::create(PyObject* object)
{
	auto shared_ptr = std::shared_ptr<DerivableAffector>(new DerivableAffector(object), D());
	return std::static_pointer_cast<thor::Affector>(shared_ptr);
}

DerivableAffector::DerivableAffector(PyObject* object):
thor::Affector (),
object         (object)
{
	Py_INCREF(object);

	PyEval_InitThreads();
	import_sfml__system();
	import_thor__particles();
}

DerivableAffector::~DerivableAffector()
{
}

void DerivableAffector::affect(thor::Particle& particle, sf::Time dt)
{
	static char method[] = "affect";
    static char format[] = "(O, O)";

	PyObject* particle_object = (PyObject*)(wrap_particle(&particle));
	PyObject* dt_object = (PyObject*)(wrap_time(&dt));

    PyObject_CallMethod(object, method, format, particle_object, dt_object);
}
