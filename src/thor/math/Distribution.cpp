/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#include "Distribution.hpp"

PyObject* Function::operator() ()
{
    return factory();
}

DistributionFunctor::DistributionFunctor(PyObject* object)
{
    this->object = object;
}

PyObject* DistributionFunctor::operator() ()
{
    return PyObject_CallObject(object, NULL);
}

Function wrapDistributionFunctor(DistributionFunctor distributionFunctor)
{
    return Function(distributionFunctor);
}

IntDistribution::IntDistribution(thor::Distribution<int>* distribution)
: distribution(distribution)
{
	import_sfml__system();
}

PyObject* IntDistribution::operator () ()
{
    int value = (*distribution)();
	return PyLong_FromLong(value);
}

FloatDistribution::FloatDistribution(thor::Distribution<float>* distribution)
: distribution(distribution)
{
	import_sfml__system();
}

PyObject* FloatDistribution::operator () ()
{
    float value = (*distribution)();
	return PyFloat_FromDouble(value);
}

Vector2fDistribution::Vector2fDistribution(thor::Distribution<sf::Vector2f>* distribution)
: distribution(distribution)
{
	import_sfml__system();
}

PyObject* Vector2fDistribution::operator () ()
{
    sf::Vector2f vector = (*distribution)();
	return wrap_vector2f(vector);
}

TimeDistribution::TimeDistribution(thor::Distribution<sf::Time>* distribution)
: distribution(distribution)
{
	import_sfml__system();
}

PyObject* TimeDistribution::operator () ()
{
    // fix-me: replace with non pointer version
    sf::Time* value = new sf::Time;
    *value = (*distribution)();
    return wrap_time(value);
}

Function wrapDistributionInt(IntDistribution distribution)
{
    return Function(distribution);
}

Function wrapDistributionFloat(FloatDistribution distribution)
{
    return Function(distribution);
}

Function wrapDistributionVector2f(Vector2fDistribution distribution)
{
    return Function(distribution);
}

Function wrapDistributionTime(TimeDistribution distribution)
{
    return Function(distribution);
}

