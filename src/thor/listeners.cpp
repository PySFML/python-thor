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
