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

#include "Resource.hpp"

#include <iostream>

Identifier::Identifier()
: m_object(NULL)
{
}

Identifier::Identifier(PyObject* object)
: m_object(object)
{
    Py_XINCREF(m_object);
}

Identifier::~Identifier()
{
    Py_XDECREF(m_object);
}

PyObject* Identifier::get()
{
    Py_XINCREF(m_object);
    return m_object;
}

void Identifier::set(PyObject* object)
{
    if (m_object)
        Py_DECREF(m_object);

    m_object = object;
    Py_INCREF(m_object);
}

bool Identifier::operator<(const Identifier& b) const
{
    //true if lhs < rhs, false otherwise.
    return PyObject_RichCompareBool(m_object, b.m_object, Py_LT);
}

Resource::Resource()
: m_object(NULL)
{
}

Resource::Resource(PyObject* object)
: m_object(object)
{
    Py_XINCREF(m_object);
}

Resource::~Resource()
{
    Py_XDECREF(m_object);
}

bool Resource::loadFromFile(const std::string& filename, PyObject* type_)
{
    std::cout << "test " << std::endl;
    m_object = PyObject_CallMethod(type_, "from_file", "O", PyUnicode_FromFormat(filename.c_str()));

    return true;
}

PyObject* Resource::get()
{
    Py_XINCREF(m_object);
    return m_object;
}

ResourceLoaderFunction::ResourceLoaderFunction(PyObject* function)
: function(function)
{
}

std::unique_ptr<Resource> ResourceLoaderFunction::operator() ()
{
    PyObject* resource = PyObject_CallFunction(function, NULL);

    // fix-me: handle resource == NULL
    //return std::unique_ptr<PyObject*>(resource);
    //return std::make_unique<Resource>(resource);

    return std::unique_ptr<Resource>(new Resource(resource));
}

PyObject* loadResource(thor::ResourceLoader<Resource>* resourceLoader)
{
    std::unique_ptr<Resource> resource = resourceLoader->load();

    return resource->get();
}

PyObject* acquireResource(thor::ResourceHolder<Resource, Identifier, thor::Resources::RefCounted>* resourceHolder, Identifier id, thor::ResourceLoader<Resource>* how, thor::Resources::KnownIdStrategy known)
{
    return resourceHolder->acquire(id, *how, known)->get();
}

PyObject* getResource(thor::ResourceHolder<Resource, Identifier, thor::Resources::RefCounted>* resourceHolder, Identifier id)
{
    return (*resourceHolder)[id]->get();
}

thor::ResourceLoader<Resource>* heinFromFile(PyObject* type_, const std::string& filename)
{
    thor::ResourceLoader<Resource>* test;
    test = new thor::ResourceLoader<Resource>(thor::Resources::fromFile<Resource>(filename, type_));

    return test;
}
