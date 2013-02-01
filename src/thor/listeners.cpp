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


#include "listeners.hpp"
#include "time_api.h"
#include <iostream>
struct CallPythonFunction
{
	CallPythonFunction(PyObject* object)
	: object(object)
	{
		import_thor__time();
	}

	void operator()(thor::CallbackTimer& timer)
	{
		PyGILState_STATE gstate;
		gstate = PyGILState_Ensure();

		//static char format[] = "O";

		PyObject* timer_object = (PyObject*)(wrap_callbacktimer(&timer));
		PyObject_CallFunctionObjArgs(object, timer_object, NULL);


		PyGILState_Release(gstate);
	}

	PyObject* object;
};

thor::Connection CallbackTimer_connect(thor::CallbackTimer* timer, PyObject* object)
{
	return timer->connect(CallPythonFunction(object));
}
