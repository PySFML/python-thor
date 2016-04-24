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

#include "Input.hpp"

#include <SFML/Window.hpp>
#include <pysfml/window/window.h>
#include <pysfml/window/window_api.h>

EventActionFunctor::EventActionFunctor(PyObject* object)
: object(object)
{
    import_sfml__window();
}

bool EventActionFunctor::operator() (const sf::Event& event)
{
    // fix-me: check if error occured
    //PyObject* result = PyObject_CallFunction();
    //return PyObject_IsTrue(result);

    sf::Event* ev = new sf::Event;
    *ev = event;

    PyEventObject* test = wrap_event(ev);

    PyObject* result = PyObject_CallFunctionObjArgs(object, ev, NULL);
    return PyObject_IsTrue(result);
}

RealtimeActionFunctor::RealtimeActionFunctor(PyObject* object)
: object(object)
{
}

bool RealtimeActionFunctor::operator() ()
{
    PyObject* result = PyObject_CallFunction(object, NULL);
    return PyObject_IsTrue(result);
}

thor::Action* actionAndOperator(thor::Action* lhs, thor::Action* rhs)
{
    thor::Action* action = new thor::Action(*lhs && *rhs);
    return action;
}

thor::Action* actionOrOperator(thor::Action* lhs, thor::Action* rhs)
{
    thor::Action* action = new thor::Action(*lhs || *rhs);
    return action;
}

thor::Action* actionNotOperator(thor::Action* lhs)
{
    thor::Action* action = new thor::Action(!*lhs);
    return action;
}

thor::Action* actionEventAction(PyObject* filter)
{
    thor::Action* action = new thor::Action(thor::eventAction(EventActionFunctor(filter)));
    return action;
}

thor::Action* actionRealtimeAction(PyObject* filter)
{
    thor::Action* action = new thor::Action(thor::realtimeAction(RealtimeActionFunctor(filter)));
    return action;
}

ActionId::ActionId(PyObject* object)
: m_object(object)
{
    Py_XINCREF(m_object);
}

ActionId::~ActionId()
{
    Py_XDECREF(m_object);
}

PyObject* ActionId::get()
{
    Py_XINCREF(m_object);
    return m_object;
}

bool ActionId::operator<(const ActionId& b) const
{
    // ni plus grand, ni plus peti

    //true if lhs < rhs, false otherwise.
    return PyObject_RichCompareBool(m_object, b.m_object, Py_LT);

    //return PyObject_RichCompareBool(m_object, b.m_object, Py_NE);

    //if (PyObject_RichCompareBool(m_object, b.m_object, Py_EQ))
        //return false;
}

//EventId::EventId(PyObject* object)
//: m_object(object)
//{
    //Py_XINCREF(m_object);
//}

//EventId::~EventId()
//{
    //Py_XDECREF(m_object);
//}

//PyObject* EventId::get()
//{
    //Py_XINCREF(m_object);
    //return m_object;
//}

//bool EventId::operator<(const EventId& b) const
//{
    ////true if lhs < rhs, false otherwise.
    //return PyObject_RichCompareBool(m_object, b.m_object, Py_LT);
//}

//Event::Event()
//: m_object(NULL)
//{
//}

//Event::Event(PyObject* object)
//: m_object(object)
//{
    //Py_XINCREF(m_object);
//}

//Event::~Event()
//{
    //Py_XDECREF(m_object);
//}

//PyObject* Event::get()
//{
    //Py_XINCREF(m_object);
    //return m_object;
//}

//void Event::set(PyObject* object)
//{
    //if (m_object)
        //Py_DECREF(m_object);

    //m_object = object;
    //Py_INCREF(m_object);
//}

//EventListener::EventListener(PyObject* listener)
//{
    //this->listener = listener;
//}

//void EventListener::operator() (const Event& event)
//{
    ///// dynamically detect if support one argument
    //// if yes, PyObject_CallFunction(m_listener, wrapEvent(event)
    //// if not, PyObject_CallFunctoin(m_listener, NULL)
    //std::cout << "it works!" << std::endl;
//}

//thor::Connection connect(thor::EventSystem<Event, EventId>* eventSystem, PyObject* trigger, PyObject* listener)
//{
    //return eventSystem->connect(EventId(trigger), EventListener(listener));
//}
