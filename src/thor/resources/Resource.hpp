//------------------------------------------------------------------------------
// PyThor - Python bindings for Thor
// Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from the
// use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software in a
//    product, an acknowledgment in the product documentation would be
//    appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such, and must not be
//    misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.
//------------------------------------------------------------------------------

#ifndef PYTHOR_RESOURCE_HPP
#define PYTHOR_RESOURCE_HPP

#include "Python.h"
#include <Thor/Resources.hpp>
#include <memory>

class Identifier
{
public:
    Identifier();
    Identifier(PyObject* object);
    ~Identifier();

    PyObject* get();
    void set(PyObject* object);

    bool operator<(const Identifier& b) const;

private:
    PyObject* m_object;
};

class Resource
{
public:
    Resource();
    Resource(PyObject* object);
    ~Resource();

    bool loadFromFile(const std::string& filename, PyObject* type_);

    PyObject* get();

private:
    //std::shared_ptr<PyO
    PyObject* m_object;
};

struct ResourceLoaderFunction
{
    ResourceLoaderFunction(PyObject* function);

    std::unique_ptr<Resource> operator() ();

    PyObject* function;
};

PyObject* loadResource(thor::ResourceLoader<Resource>* resourceLoader);

PyObject* acquireResource(thor::ResourceHolder<Resource, Identifier, thor::Resources::RefCounted>* resourceHolder, Identifier id, thor::ResourceLoader<Resource>* how, thor::Resources::KnownIdStrategy known);
PyObject* getResource(thor::ResourceHolder<Resource, Identifier, thor::Resources::RefCounted>* resourceHolder, Identifier id);

thor::ResourceLoader<Resource>* heinFromFile(PyObject* type_, const std::string& filename);

#endif // PYTHOR_RESOURCE_HPP
