/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#ifndef PYTHOR_ANIMATIONS_ANIMATIONFUNCTION_HPP
#define PYTHOR_ANIMATIONS_ANIMATIONFUNCTION_HPP

#include "Python.h"
#include "Object.hpp"
#include <Thor/Math.hpp>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <pysfml/system/NumericObject.hpp>

struct AnimationFunction
{
    AnimationFunction(PyObject* function);

    void operator() (Object animated, float progress);

    PyObject* m_pyfunction;
};

struct ColorizableObject
{
    ColorizableObject(PyObject* object);

    const sf::Color getColor() const;
    void setColor(const sf::Color& color);

    PyObject* object;
};

//struct FadableObject
//{
    //FadableObject(PyObject* object);

    //void setAlpha(sf::Uint8 alpha);

    //PyObject* object;
//};

struct FramableObject
{
    FramableObject(PyObject* object);

    void setTextureRect(const sf::IntRect& rectangle);
    void setOrigin(const sf::Vector2f origin);

    PyObject* object;
};

#endif // PYTHOR_ANIMATIONS_ANIMATIONFUNCTION_HPP

