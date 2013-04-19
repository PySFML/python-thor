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

#include "DistributionAPI.hpp"

DistributionObjectFunctor::DistributionObjectFunctor(PyObject* object) :
m_object (object)
{
}

PyObject* DistributionObjectFunctor::operator() () const
{
	return PyObject_CallFunctionObjArgs(m_object, NULL);
}


DistributionObject::DistributionObject(PyObject* object) :
DistributionAPI (DistributionObjectFunctor(object)),
m_object(object)
{
	Py_INCREF(m_object);
}

DistributionObject::~DistributionObject()
{
}

thor::Distribution<float> DistributionObject::getFloatFunctor()
{
	return thor::Distribution<float>(ObjectToFloatFunctor(m_object));
}

thor::Distribution<sf::Vector2f> DistributionObject::getVector2Functor()
{
	return thor::Distribution<sf::Vector2f>(ObjectToVector2Functor(m_object));
}

thor::Distribution<sf::Time> DistributionObject::getTimeFunctor()
{
	return thor::Distribution<sf::Time>(sf::seconds(1));
}

thor::Distribution<sf::Color> DistributionObject::getColorFunctor()
{
	return thor::Distribution<sf::Color>(sf::Color::Red);
}


DistributionFloat::DistributionFloat(thor::Distribution<float> distribution) :
DistributionAPI (FloatToObjectFunctor(distribution)),
m_distribution(distribution)
{
}

DistributionFloat::~DistributionFloat()
{
}

thor::Distribution<float> DistributionFloat::getFloatFunctor()
{
	return m_distribution;
}

thor::Distribution<sf::Vector2f> DistributionFloat::getVector2Functor()
{
	return sf::Vector2f();
}

thor::Distribution<sf::Time> DistributionFloat::getTimeFunctor()
{
	return sf::seconds(1);
}

thor::Distribution<sf::Color> DistributionFloat::getColorFunctor()
{
	return sf::Color::Red;
}



DistributionVector2::DistributionVector2(thor::Distribution<sf::Vector2f> distribution) :
DistributionAPI (Vector2ToObjectFunctor(distribution)),
m_distribution(distribution)
{
}

DistributionVector2::~DistributionVector2()
{
}

thor::Distribution<float> DistributionVector2::getFloatFunctor()
{
	return 0;
}

thor::Distribution<sf::Vector2f> DistributionVector2::getVector2Functor()
{
	return m_distribution;
}

thor::Distribution<sf::Time> DistributionVector2::getTimeFunctor()
{
	return sf::seconds(1);
}

thor::Distribution<sf::Color> DistributionVector2::getColorFunctor()
{
	return sf::Color::Red;
}


DistributionTime::DistributionTime(thor::Distribution<sf::Time> distribution) :
DistributionAPI (TimeToObjectFunctor(distribution)),
m_distribution(distribution)
{
}

DistributionTime::~DistributionTime()
{
}

thor::Distribution<float> DistributionTime::getFloatFunctor()
{
	return 0;
}

thor::Distribution<sf::Vector2f> DistributionTime::getVector2Functor()
{
	return sf::Vector2f();
}

thor::Distribution<sf::Time> DistributionTime::getTimeFunctor()
{
	return m_distribution;
}

thor::Distribution<sf::Color> DistributionTime::getColorFunctor()
{
	return sf::Color::Red;
}


DistributionColor::DistributionColor(thor::Distribution<sf::Color> distribution) :
DistributionAPI (ColorToObjectFunctor(distribution)),
m_distribution(distribution)
{
}

DistributionColor::~DistributionColor()
{
}

thor::Distribution<float> DistributionColor::getFloatFunctor()
{
	return 0;
}

thor::Distribution<sf::Vector2f> DistributionColor::getVector2Functor()
{
	return sf::Vector2f();
}

thor::Distribution<sf::Time> DistributionColor::getTimeFunctor()
{
	return sf::seconds(1);
}

thor::Distribution<sf::Color> DistributionColor::getColorFunctor()
{
	return m_distribution;
}


//////////////////////////////////////////////////////////////////////////////
FloatToObjectFunctor::FloatToObjectFunctor(thor::Distribution<float> distribution) :
m_distribution (distribution)
{
	import_sfml__system();
}

FloatToObjectFunctor::~FloatToObjectFunctor()
{
}

PyObject* FloatToObjectFunctor::operator() () const
{
	return PyFloat_FromDouble(m_distribution());
}

Vector2ToObjectFunctor::Vector2ToObjectFunctor(thor::Distribution<sf::Vector2f> distribution) :
m_distribution (distribution)
{
	import_sfml__system();
}

Vector2ToObjectFunctor::~Vector2ToObjectFunctor()
{
}

PyObject* Vector2ToObjectFunctor::operator() () const
{
	// TODO: improve the following code once the new Vector2API is set up
	sf::Vector2f* p = new sf::Vector2f;
	*p = m_distribution();
	PyObject* ret = wrap_vector2f(p);
	delete p;
	return ret;
}

TimeToObjectFunctor::TimeToObjectFunctor(thor::Distribution<sf::Time> distribution) :
m_distribution (distribution)
{
	import_sfml__system();
}

TimeToObjectFunctor::~TimeToObjectFunctor()
{
}

PyObject* TimeToObjectFunctor::operator() () const
{
	sf::Time* p = new sf::Time;
	*p = m_distribution();
	return wrap_time(p);
}

ColorToObjectFunctor::ColorToObjectFunctor(thor::Distribution<sf::Color> distribution) :
m_distribution (distribution)
{
	import_sfml__graphics();
}

ColorToObjectFunctor::~ColorToObjectFunctor()
{
}

PyObject* ColorToObjectFunctor::operator() () const
{
	sf::Color* p = new sf::Color;
	*p = m_distribution();
	return wrap_color(p);
}


////////////////////////////////////////////////////////////////////////////////

ObjectToFloatFunctor::ObjectToFloatFunctor(PyObject* object):
m_object (object)
{
}

ObjectToFloatFunctor::~ObjectToFloatFunctor()
{
}

float ObjectToFloatFunctor::operator() () const
{
	PyObject* response = PyObject_CallFunctionObjArgs(m_object, NULL);
	return PyFloat_AsDouble(response);
}

ObjectToVector2Functor::ObjectToVector2Functor(PyObject* object):
m_object (object)
{
}

ObjectToVector2Functor::~ObjectToVector2Functor()
{
}

sf::Vector2f ObjectToVector2Functor::operator() () const
{
	PyObject* response = PyObject_CallObject(m_object, NULL);
	PyVector2Object* vector2 = (PyVector2Object*)(response);
	return sf::Vector2f(PyFloat_AsDouble(vector2->x), PyFloat_AsDouble(vector2->y));
}

ObjectToTimeFunctor::ObjectToTimeFunctor(PyObject* object):
m_object (object)
{
}

ObjectToTimeFunctor::~ObjectToTimeFunctor()
{
}

sf::Time ObjectToTimeFunctor::operator() () const
{
	PyObject* response = PyObject_CallFunctionObjArgs(m_object, NULL);
	PyTimeObject* time = (PyTimeObject*)(response);
	return *time->p_this;
}

ObjectToColorFunctor::ObjectToColorFunctor(PyObject* object):
m_object (object)
{
}

ObjectToColorFunctor::~ObjectToColorFunctor()
{
}

sf::Color ObjectToColorFunctor::operator() () const
{
	PyObject* response = PyObject_CallFunctionObjArgs(m_object, NULL);
	PyColorObject* color = (PyColorObject*)(response);
	return *color->p_this;
}
