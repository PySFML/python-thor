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

#ifndef PYTHOR_INPUT_HPP
#define PYTHOR_INPUT_HPP

#include "Python.h"
#include <Thor/Input.hpp>

struct EventActionFunctor
{
    EventActionFunctor(PyObject* object);

    bool operator() (const sf::Event& event);

    PyObject* object;
};

struct RealtimeActionFunctor
{
    RealtimeActionFunctor(PyObject* object);

    bool operator() ();

    PyObject* object;
};

thor::Action* actionAndOperator(thor::Action* lhs, thor::Action* rhs);
thor::Action* actionOrOperator(thor::Action* lhs, thor::Action* rhs);
thor::Action* actionNotOperator(thor::Action* lhs);

thor::Action* actionEventAction(PyObject* filter);
thor::Action* actionRealtimeAction(PyObject* filter);

class ActionId
{
public:
    ActionId(PyObject* object);
    ~ActionId();

    PyObject* get();

    bool operator<(const ActionId& b) const;

private:
    PyObject* m_object;
};

class EventId
{
public:
    EventId(PyObject* object);
    ~EventId();

    PyObject* get();

    bool operator<(const ActionId& b) const;

private:
    PyObject* m_object;
};

class Event
{
public:
    Event();
    Event(PyObject* object);
    ~Event();

    PyObject* get();
    void set(PyObject* object);

private:
    PyObject* m_object;
};

struct EventListener
{
    EventListener(PyObject* listener);

    void operator() (const Event& event);

    PyObject* listener;
};

thor::Connection connect(thor::EventSystem<Event, EventId>* eventSystem, PyObject* trigger, PyObject* listener);

#endif // PYTHOR_INPUT_HPP
