#-------------------------------------------------------------------------------
# PyThor - Python bindings for Thor
# Copyright (c) 2013-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is provided 'as-is', without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from the
# use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software in a
#    product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
#
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
#
# 3. This notice may not be removed or altered from any source distribution.
#-------------------------------------------------------------------------------

cimport sfml as sf
cimport thor as th

from pysfml.system cimport Time, wrap_time
from pythor.input cimport wrap_connection

cdef extern from "TimerFunctor.hpp" namespace "":
    th.Connection CallbackTimer_connect(th.CallbackTimer*, object)

__all__ = ['Timer', 'CallbackTimer', 'StopWatch']

cdef class Timer:
    cdef th.Timer *p_timer

    def __init__(self):
        if self.p_timer == NULL:
            self.p_timer = new th.Timer()

    def __dealloc__(self):
        if self.p_timer != NULL:
            del self.p_timer

    property remaining_time:
        def __get__(self):
            cdef sf.Time* p = new sf.Time()
            p[0] = self.p_timer.getRemainingTime()
            return wrap_time(p)

    property running:
        def __get__(self):
            return self.p_timer.isRunning()

    property expired:
        def __get__(self):
            return self.p_timer.isExpired()

    def start(self):
        self.p_timer.start()

    def stop(self):
        self.p_timer.stop()

    def reset(self, Time time_limit):
        self.p_timer.reset(time_limit.p_this[0])

    def restart(self, Time time_limit):
        self.p_timer.restart(time_limit.p_this[0])


cdef class CallbackTimer(Timer):
    cdef th.CallbackTimer *p_this

    def __init__(self):
        if self.p_this == NULL:
            self.p_this = new th.CallbackTimer()
            self.p_timer = <th.Timer*>self.p_this

    def __dealloc__(self):
        self.p_timer = NULL
        if self.p_this != NULL:
            del self.p_this

    def update(self):
        self.p_this.update()

    def connect(self, function):
        cdef th.Connection *p = new th.Connection()
        p[0] = CallbackTimer_connect(self.p_this, function)
        return wrap_connection(p)

    def clear_connections(self):
        self.p_this.clearConnections()


cdef class StopWatch:
    cdef th.StopWatch *p_this

    def __init__(self):
        self.p_this = new th.StopWatch()

    def __dealloc__(self):
        del self.p_this

    property elapsed_time:
        def __get__(self):
            cdef sf.Time* p = new sf.Time()
            p[0] = self.p_this.getElapsedTime()
            return wrap_time(p)

    property running:
        def __get__(self):
            return self.p_this.isRunning()

    def start(self):
        self.p_this.start()

    def stop(self):
        self.p_this.stop()

    def reset(self):
        self.p_this.reset()

    def restart(self):
        self.p_this.restart()
