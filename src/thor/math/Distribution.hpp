/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#ifndef PYTHOR_MATH_DISTRIBUTION_HPP
#define PYTHOR_MATH_DISTRIBUTION_HPP

#include "Python.h"
#include "Rule.hpp"
#include <Thor/Math.hpp>
#include <SFML/System.hpp>
#include <pysfml/system/NumericObject.hpp>
#include <pysfml/system/system_api.h>
#include <functional>
#include <memory>

struct Function
{
    template <typename Fn>
    Function(Fn factory);

    PyObject* operator() ();

    std::function<PyObject*()> factory;
};

struct DistributionFunctor
{
    DistributionFunctor(PyObject* object);

    PyObject* operator() ();

    PyObject* object;
};

Function wrapDistributionFunctor(DistributionFunctor distributionFunctor);

struct IntDistribution
{
    IntDistribution(thor::Distribution<int>* distribution);

    PyObject* operator () ();

    std::shared_ptr<thor::Distribution<int>> distribution;
};

struct FloatDistribution
{
    FloatDistribution(thor::Distribution<float>* distribution);

    PyObject* operator () ();

    std::shared_ptr<thor::Distribution<float>> distribution;
};

struct Vector2fDistribution
{
    Vector2fDistribution(thor::Distribution<sf::Vector2f>* distribution);

    PyObject* operator () ();

    std::shared_ptr<thor::Distribution<sf::Vector2f>> distribution;
};

struct TimeDistribution
{
    TimeDistribution(thor::Distribution<sf::Time>* distribution);

    PyObject* operator () ();

    std::shared_ptr<thor::Distribution<sf::Time>> distribution;
};

Function wrapDistributionInt(IntDistribution distribution);
Function wrapDistributionFloat(FloatDistribution distribution);
Function wrapDistributionVector2f(Vector2fDistribution distribution);
Function wrapDistributionTime(TimeDistribution distribution);

#include "Distribution.inl"

#endif // PYTHOR_MATH_DISTRIBUTION_HPP
