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


#ifndef PYTHOR_MATH_DISTRIBUTION_HPP
#define PYTHOR_MATH_DISTRIBUTION_HPP

#include "Python.h"

#include <SFML/System.hpp>
#include <SFML/Graphics.hpp>

#include <pysfml/system_api.h>
#include <pysfml/system.h>

#include <Thor/Math.hpp>

#include <pysfml/graphics_api.h>
#include <pysfml/graphics.h>

class DistributionAPI: public thor::Distribution<PyObject*>
{
public :
	template <typename Fn>
	DistributionAPI(Fn function AURORA_ENABLE_IF(!std::is_convertible<Fn, PyObject*>::value)):
	thor::Distribution<PyObject*> (function)
	{
	}

	virtual ~DistributionAPI()
	{
	}

	virtual thor::Distribution<float>        getFloatFunctor()=0;
	virtual thor::Distribution<sf::Vector2f> getVector2Functor()=0;
	virtual thor::Distribution<sf::Time>     getTimeFunctor()=0;
	virtual thor::Distribution<sf::Color>    getColorFunctor()=0;
};

class DistributionObjectFunctor
{
public:
	DistributionObjectFunctor(PyObject*);

	PyObject* operator() () const;

private:
	PyObject* m_object;
};

class DistributionObject: public DistributionAPI
{
public:
	DistributionObject(PyObject*);
	~DistributionObject();

	thor::Distribution<float>        getFloatFunctor();
	thor::Distribution<sf::Vector2f> getVector2Functor();
	thor::Distribution<sf::Time>     getTimeFunctor();
	thor::Distribution<sf::Color>    getColorFunctor();

private:
	PyObject* m_object;
};


class DistributionFloat: public DistributionAPI
{
public:
	DistributionFloat(thor::Distribution<float>);
	~DistributionFloat();

	thor::Distribution<float>        getFloatFunctor();
	thor::Distribution<sf::Vector2f> getVector2Functor();
	thor::Distribution<sf::Time>     getTimeFunctor();
	thor::Distribution<sf::Color>    getColorFunctor();

private:
	thor::Distribution<float> m_distribution;
};


class DistributionVector2: public DistributionAPI
{
public:
	DistributionVector2(thor::Distribution<sf::Vector2f>);
	~DistributionVector2();

	thor::Distribution<float>        getFloatFunctor();
	thor::Distribution<sf::Vector2f> getVector2Functor();
	thor::Distribution<sf::Time>     getTimeFunctor();
	thor::Distribution<sf::Color>    getColorFunctor();

private:
	thor::Distribution<sf::Vector2f> m_distribution;
};


class DistributionTime: public DistributionAPI
{
public:
	DistributionTime(thor::Distribution<sf::Time>);
	~DistributionTime();

	thor::Distribution<float>        getFloatFunctor();
	thor::Distribution<sf::Vector2f> getVector2Functor();
	thor::Distribution<sf::Time>     getTimeFunctor();
	thor::Distribution<sf::Color>    getColorFunctor();

private:
	thor::Distribution<sf::Time> m_distribution;
};


class DistributionColor: public DistributionAPI
{
public:
	DistributionColor(thor::Distribution<sf::Color>);
	~DistributionColor();

	thor::Distribution<float>        getFloatFunctor();
	thor::Distribution<sf::Vector2f> getVector2Functor();
	thor::Distribution<sf::Time>     getTimeFunctor();
	thor::Distribution<sf::Color>    getColorFunctor();

private:
	thor::Distribution<sf::Color> m_distribution;
};


class FloatToObjectFunctor
{
public:
	FloatToObjectFunctor(thor::Distribution<float>);
	~FloatToObjectFunctor();

	PyObject* operator() () const;

private:
	thor::Distribution<float> m_distribution;
};


class Vector2ToObjectFunctor
{
public:
	Vector2ToObjectFunctor(thor::Distribution<sf::Vector2f>);
	~Vector2ToObjectFunctor();

	PyObject* operator() () const;

private:
	thor::Distribution<sf::Vector2f> m_distribution;
};


class TimeToObjectFunctor
{
public:
	TimeToObjectFunctor(thor::Distribution<sf::Time>);
	~TimeToObjectFunctor();

	PyObject* operator() () const;

private:
	thor::Distribution<sf::Time> m_distribution;
};

class ColorToObjectFunctor
{
public:
	ColorToObjectFunctor(thor::Distribution<sf::Color>);
	~ColorToObjectFunctor();

	PyObject* operator() () const;

private:
	thor::Distribution<sf::Color> m_distribution;
};


class ObjectToFloatFunctor
{
public:
	ObjectToFloatFunctor(PyObject*);
	~ObjectToFloatFunctor();

	float operator() () const;

private:
	PyObject* m_object;
};

class ObjectToVector2Functor
{
public:
	ObjectToVector2Functor(PyObject*);
	~ObjectToVector2Functor();

	sf::Vector2f operator() () const;

private:
	PyObject* m_object;
};

class ObjectToTimeFunctor
{
public:
	ObjectToTimeFunctor(PyObject*);
	~ObjectToTimeFunctor();

	sf::Time operator() () const;

private:
	PyObject* m_object;
};


class ObjectToColorFunctor
{
public:
	ObjectToColorFunctor(PyObject*);
	~ObjectToColorFunctor();

	sf::Color operator() () const;

private:
	PyObject* m_object;
};

#endif // PYTHOR_MATH_DISTRIBUTION_HPP
