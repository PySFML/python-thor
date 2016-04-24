Time
====
There isn't any complete documentation or API reference for the
time module of pyThor yet. Everything below is just quick notes. You'll
also find numerous piece of code to understand how to use this module.

In general, features translate trivially into Python and with the absence
of a complete API reference, you should refer to the C++ documentation to
understand how this module work. Indeed, Python and C++ aren't the same
language and several time, features had to be implemented differently or
simply omitted. This is where this incomplete documention comes in handy
because it lists the things you should know to fill that gap.

Below, you'll find various developer notes. Unless you want to hack the
source code, it's unlikely that they are relevant to you. Please, ignore
them; I had to store them somewhere.

StopWatch
---------
There's simply nothing to say about that one. Everything works exactly
the same ::

    stopwatch = th.StopWatch()

    # start the stopwatch
    stopwatch.start()

    # reset it to 0, and stop it
    stopwatch.reset()

    # reset it to 0 followed by a start
    stopwatch.restart()

    # print out the elapsed time
    print(stopwatch.elapsed_time)

    # check if the stopwatch is running
    if stopwatch.is_running():
        print("The stopwatch is running")

    # stop it
    stopwatch.stop()

Timers
------
Unlike a stopwatch, time goes backward and stop running once it reaches
time zero. ::

    timer = th.Timer()

    # set the timer at 1 second but don't run it
    timer.reset(sf.seconds(1))

    # start the timer
    timer.start()

    # check if running and print out the remaining time
    while timer.is_running():
        print(timer.remaining_time)

    # restart the timer at 1 second and run it immediately afterward
    timer.restart(sf.seconds(1))

    # pause the timer after half a second
    sf.sleep(sf.seconds(0.5))
    timer.stop()

    # check if the timer is expired
    if timer.is_expired():
        print("That message should never be print out")

The Thor library also implements a timer that calls a callback once it
reaches time zero. This is `CallbackTimer` and it inherits from `Timer`.
Besides the same functionalities shown above, you can connect a callback. ::

    def listener_1(timer):
        print("Callback with arity 1")

    def listener_0():
        print("Callback with arity 0")

    callback_timer = th.CallbackTimer()

    # by default, it expects the listener that takes 1 argument
    callback_timer.connect(listener_1)

    # but you can cancell it out with a lambda function
    callback_timer.connect(lambda timer: listener_0())

    # frequently call the update() methods to trigger callbacks
    callback_timer.update()

    # clear out previously connected callbacks
    callback_timer.clear_connections()

Like shown in this example, there's no connect0() method just like in
the original library. Instead use lambda to quickly clear out the
first parameter.

**Warning**: There's a known bug, when you connect more than one callback, it will result in segfault.

To disconnect on specific callback without using `clear_connections()` which
disconnect all of them, you can remember the connection instance return by the
`connect()` method. ::

    connection = callback_timer.connect(listener_1)

    # later ...
    connection.disconnect()


You can implement your own timers and override method reset and restart()
just like in C++
You can also subclass CallbackTimer and provide.

Developers notes
----------------
1) To connect a listener (aka 'a function') to a callback timer, we
use the method `CallbackTimer.connect(listener)`. The expected function
arity is one, where the first argument is the callback timer itself.
In C++, two methods

be 1, however, it makes sense

def listener_0():
    print("CallbackTimer: time out from LISTENER_0")

def listener_1(callback_timer):
    print("CallbackTimer: time out from LISTENER_1({0})".format(callback_timer))

callback_timer.connect(lambda timer: listener_0())
#callback_timer.connect(listener_1)

2) Par facilité, j'ai passé l'object
