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


#include "triangulation.hpp"



#include <iostream>

//thor::Triangle<void*>* Triangle_initialization(void* c1, void* c2, void* c3)
//{
	//std::cout << "Triangle_initialization" << std::endl;
	//std::cout << c1 << std::endl;
	//std::cout << c2 << std::endl;
	//std::cout << c3 << std::endl;

	//thor::Triangle<void*>* mytri = new thor::Triangle<void*>(c1, c2, c3);

	//std::cout << mytri << std::endl;

	//std::cout << (*mytri)[0] << std::endl;
	//std::cout << (*mytri)[1] << std::endl;
	//std::cout << (*mytri)[2] << std::endl;

	//return mytri;
//}

//void* Triangle_get(thor::Triangle<void*>& triangle, unsigned int index)
//{
	//void *c1, *c2, *c3;
	//std::cout << "Triangle_get: index " << index << std::endl;
	//c1 = triangle[0];
	//c2 = triangle[1];
	//c3 = triangle[2];
	//std::cout << c1 << std::endl;
	//std::cout << c2 << std::endl;
	//std::cout << c3 << std::endl;
	//std::cout << &triangle << std::endl;
	//return triangle[index];
//}


PyObject* temp_wrap_vector2(const sf::Vector2f& v2)
{
	// this function will be removed once I rewrote Vector2 API in pysfml
	// it's a dirty implementation but things should get cleaner and it avoids
	// using -fpermissive temporarlily

	sf::Vector2f* vector = new sf::Vector2f(v2);
	PyObject* temp = (PyObject*)wrap_vector2f(vector);
	Py_INCREF(temp);

	delete vector;
	return temp;
}

PyObject* triangulate(PyObject* list)
{
	std::cout << "aa" << std::endl;
	import_sfml__system();
	import_thor__math();

	std::cout << "bb" << std::endl;
	std::vector<sf::Vector2f> vertices;
	std::vector<thor::Triangle<sf::Vector2f>> triangles;

	// build vertices vector from the python list
	int i, n;
	PyObject *item, *x, *y;

	n = PyList_Size(list);
	if (n < 0)
		return NULL;

	std::cout << "cc" << std::endl;
	for (i = 0; i < n; i++)
	{
		item = PyList_GetItem(list, i);

		x = PyObject_GetItem(item, PyInt_FromLong(0));
		y = PyObject_GetItem(item, PyInt_FromLong(1));

		std::cout << PyFloat_AsDouble(x) << " & " << PyFloat_AsDouble(y) << std::endl;
		
		vertices.push_back(sf::Vector2f(PyFloat_AsDouble(x), PyFloat_AsDouble(y)));
	}

	std::cout << "dd" << std::endl;
	thor::triangulate(vertices.begin(), vertices.end(), std::back_inserter(triangles));

	std::cout << "ee" << std::endl;
	// build result from triangles vector
	PyObject* result = PyList_New(triangles.size());
	thor::Triangle<PyObject*> *buffer;
	PyObject *vec0, *vec1, *vec2;
	n = 0;

	std::cout << "ff" << std::endl;
	for (auto it = triangles.cbegin(); it != triangles.cend(); ++it)
	{
		vec0 = (PyObject*)(temp_wrap_vector2((*it)[0]));
		vec1 = (PyObject*)(temp_wrap_vector2((*it)[0]));
		vec2 = (PyObject*)(temp_wrap_vector2((*it)[0]));
		
		////buffer = new thor::Triangle<PyObject*>(PyInt_FromLong(15), PyInt_FromLong(25), PyInt_FromLong(35));
		//buffer = new thor::Triangle<unsigned long>(vectors[0], vectors[1], vectors[2]);

		PyList_SetItem(result, n, (PyObject*)create_triangle(vec0, vec1, vec2));
		n++;
	}

	return result;
}

void triangulateConstrained(PyObject* object)
{
}

void triangulatePolygon(PyObject* object)
{
}


