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


#include "Python.h"

#include <iostream>
#include <vector>

#include <SFML/System.hpp>
#include <Thor/Math.hpp>

#include <pysfml/system.h>
#include <pysfml/system_api.h>
#include "math_api.h"


//namespace thor
//{
//template <>
//struct TriangulationTraits<unsigned long>
//{
	//static sf::Vector2f getPosition(unsigned long vertex)
	//{
		//std::cout << "getPosition <3" << std::endl;
		
		//PyObject* object = (PyObject*)vertex;
		
		//PyObject* x = (PyObject*)PyObject_GetItem(object, PyInt_FromLong(0));
		//PyObject* y = (PyObject*)PyObject_GetItem(object, PyInt_FromLong(1));

		//std::cout << PyFloat_AsDouble(x) << std::endl;
		//std::cout << PyFloat_AsDouble(y) << std::endl;

		//return sf::Vector2f(PyFloat_AsDouble(x), PyFloat_AsDouble(y));
	//}
//};
//}

//thor::Triangle<void*>* Triangle_initialization(void*, void*, void*);
//void* Triangle_get(thor::Triangle<void*>&, unsigned int);

PyObject* triangulate(PyObject*);
void triangulateConstrained(PyObject*);
void triangulatePolygon(PyObject*);
