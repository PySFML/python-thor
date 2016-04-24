/*
* PyThor - Python bindings for Thor
* Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PyThor project and is available under the zlib
* license.
*/

#include "PolarVector2.hpp"
#include "../math/TrigonometricTraits.hpp"

sf::Vector2<NumericObject>* conversionToVector2(thor::PolarVector2<NumericObject>* polarVector)
{
    return new sf::Vector2<NumericObject>(static_cast<sf::Vector2<NumericObject>>(*polarVector));
}
