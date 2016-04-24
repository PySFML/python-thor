/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#include "AnimationFunction.hpp"


#include <pysfml/system/system_api.h>
#include <pysfml/system/system.h>
#include <pysfml/graphics/graphics_api.h>

#include <functional>
#include <memory>

#include <iostream>

AnimationFunction::AnimationFunction(PyObject* function)
: m_pyfunction(function)
{
    import_sfml__system();
    import_sfml__graphics();
}

void AnimationFunction::operator() (Object animated, float progress)
{
    PyObject* tuple = Py_BuildValue("(OO)", animated.get(), PyFloat_FromDouble(progress));
    PyObject_CallObject(m_pyfunction, tuple);
}

ColorizableObject::ColorizableObject(PyObject* object)
: object(object)
{
    import_sfml__system();
    import_sfml__graphics();
}

const sf::Color ColorizableObject::getColor() const
{
    PyObject* pycolor = PyObject_GetAttrString(object, "color");

    if (!pycolor)
        std::cout << "no color" << std::endl;

    PyColorObject* color = (PyColorObject*)pycolor;

    std::cout << color->p_this->r << std::endl;
    std::cout << color->p_this->g << std::endl;
    std::cout << color->p_this->b << std::endl;

    return sf::Color::Red;
}

void ColorizableObject::setColor(const sf::Color& color)
{
    std::cout << "Colorizable::setColor(color)" << std::endl;
    // in cpy: m_obj.setColor(wrap_color(color));
}

//FadableObject::FadableObject(PyObject* object)
//: object(object)
//{
//}

//void FadableObject::setAlpha(sf::Uint8 alpha)
//{
//}

FramableObject::FramableObject(PyObject* object)
: object(object)
{
    import_sfml__system();
    import_sfml__graphics();
}

void FramableObject::setTextureRect(const sf::IntRect& rectangle)
{
    //texture_rectangle
    // fix-me: raise exception
    sf::IntRect* localCopy = new sf::IntRect(rectangle);

    PyObject_SetAttrString(object, "texture_rectangle", (PyObject*)wrap_intrect(localCopy));
}

void FramableObject::setOrigin(const sf::Vector2f origin)
{
    PyObject_SetAttrString(object, "origin", wrap_vector2f(origin));
}
