# PyThor - Python bindings for Thor
# Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PyThor project and is available under the zlib
# license.

"""
    Supplies classes to measure time. These are convenient wrappers around sf.Clock.
"""

# todo list
# ---------
# * fix wrapping time that use pointers
# * fix bug with CallbackTimer.connect() unable to connect more than one listener
#

cimport sfml as sf
cimport thor as th

from pysfml.system cimport Time, wrap_time
from pysfml.system cimport import_sfml__system
#from pythor.input cimport wrap_connection

cdef extern from "DerivableTimer.hpp":

    cdef cppclass DerivableTimer:
        DerivableTimer(object)

    void timerReset(th.Timer*, sf.Time*)
    void timerRestart(th.Timer*, sf.Time*)

    cdef cppclass DerivableCallbackTimer:
        DerivableCallbackTimer(object)

    void callbackTimerReset(th.CallbackTimer*, sf.Time*)
    void callbackTimerRestart(th.CallbackTimer*, sf.Time*)

cdef extern from "Listener.hpp":
    void connectListener(th.CallbackTimer*, object, object)

__all__ = ['Timer', 'CallbackTimer', 'StopWatch']

import_sfml__system()

cdef class Timer:
    cdef th.Timer *p_timer

    def __init__(self):
        if self.p_timer == NULL:
            self.p_timer = <th.Timer*>new DerivableTimer(self)

    def __dealloc__(self):
        if self.p_timer != NULL:
            del self.p_timer

    property remaining_time:
        def __get__(self):
            cdef sf.Time* p = new sf.Time()
            p[0] = self.p_timer.getRemainingTime()
            return wrap_time(p)

    def is_running(self):
        return self.p_timer.isRunning()

    def is_expired(self):
        return self.p_timer.isExpired()

    def start(self):
        self.p_timer.start()

    def stop(self):
        self.p_timer.stop()

    def reset(self, Time time_limit):
        timerReset(self.p_timer, time_limit.p_this)

    def restart(self, Time time_limit):
        timerRestart(self.p_timer, time_limit.p_this)

cdef class CallbackTimer(Timer):
    cdef th.CallbackTimer *p_this

    def __init__(self):
        if self.p_this == NULL:
            self.p_this  = <th.CallbackTimer*>new DerivableCallbackTimer(self)
            self.p_timer = <th.Timer*>self.p_this

    def __dealloc__(self):
        self.p_timer = NULL
        if self.p_this != NULL:
            del self.p_this

    def update(self):
        self.p_this.update()

    def connect(self, listener):
        connectListener(self.p_this, listener, self)
#        cdef th.Connection *p = new th.Connection()
#        p[0] = CallbackTimer_connect(self.p_this, function)
#        return wrap_connection(p)

    def clear_connections(self):
        self.p_this.clearConnections()

    def reset(self, Time time_limit):
        callbackTimerReset(self.p_this, time_limit.p_this)

    def restart(self, Time time_limit):
        callbackTimerRestart(self.p_this, time_limit.p_this)

cdef class StopWatch:
    cdef th.StopWatch *p_this

    def __cinit__(self):
        self.p_this = new th.StopWatch()

    def __dealloc__(self):
        del self.p_this

    property elapsed_time:
        def __get__(self):
            cdef sf.Time* p = new sf.Time()
            p[0] = self.p_this.getElapsedTime()
            return wrap_time(p)

    def is_running(self):
        return self.p_this.isRunning()

    def start(self):
        self.p_this.start()

    def stop(self):
        self.p_this.stop()

    def reset(self):
        self.p_this.reset()

    def restart(self):
        self.p_this.restart()
