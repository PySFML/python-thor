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


#include "vectors/PolarVector2Object.hpp"

PolarVector2Object::PolarVector2Object() :
PolarVector2<PyObject*>()
{	
}

PolarVector2Object::PolarVector2Object(PyObject* radius, PyObject* angle) :
PolarVector2<PyObject*>(radius, angle)
{
}

PolarVector2Object::~PolarVector2Object()
{
}


PyObject* PolarVector2Object::radius()
{
	return r;
}

void PolarVector2Object::radius(PyObject* r)
{
	this->r = r;
}


PyObject* PolarVector2Object::angle()
{
	return phi;
}

void PolarVector2Object::angle(PyObject* phi)
{
	this->phi = phi;
}
