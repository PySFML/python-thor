from sfml import sf
from thor import th

# TEST #001 th.StopWatch
stopwatch = th.StopWatch()
stopwatch.start()
sf.sleep(sf.seconds(1))
print(stopwatch.elapsed_time)

print(stopwatch.is_running())
stopwatch.stop()
print(stopwatch.is_running())
stopwatch.reset()
stopwatch.restart()

def test_timer(timer):
    timer.restart(sf.seconds(1))
    timer.start()
    sf.sleep(sf.seconds(0.2))
    print(timer.remaining_time)
    print(timer.is_running())
    print(timer.is_expired())
    sf.sleep(sf.seconds(0.5))

    timer.reset(sf.seconds(0.2))
    print(timer.is_running())
    timer.start()

    while timer.is_running():
        sf.sleep(sf.seconds(0.025))
        print(timer.remaining_time)

    print(timer.is_expired())

# TEST #002 regular timer
regular_timer = th.Timer()
test_timer(regular_timer)

# TEST #003 custom timer
class MyTimer(th.Timer):
    def __init__(self):
        th.Timer.__init__(self)

    def reset(self, time_limit):
        print("MyTimer::reset({0})".format(time_limit))
        th.Timer.reset(self, time_limit)

    def restart(self, time_limit):
        print("MyTimer::restart({0})".format(time_limit))
        th.Timer.restart(self, time_limit)

custom_timer = MyTimer()
test_timer(custom_timer)

# TEST #004 callback timer
callback_timer = th.CallbackTimer()

def listener_1(callback_timer):
    print("CallbackTimer: time out from LISTENER_1({0})".format(callback_timer))

callback_timer.connect(listener_1)

test_timer(callback_timer)

callback_timer.update()
callback_timer.clear_connections()

# TEST #005 custom callback timer
class MyCallbackTimer(th.CallbackTimer):
    def __init__(self):
        th.CallbackTimer.__init__(self)

    def reset(self, time_limit):
        print("MyCallbackTimer::reset({0})".format(time_limit))
        th.CallbackTimer.reset(self, time_limit)

    def restart(self, time_limit):
        print("MyCallbackTimer::restart({0})".format(time_limit))
        th.CallbackTimer.restart(self, time_limit)

custom_callback_timer = MyCallbackTimer()

def listener_0():
    print("CallbackTimer: time out from LISTENER_0")

custom_callback_timer.connect(lambda timer: listener_0())

test_timer(custom_callback_timer)

custom_callback_timer.update()
custom_callback_timer.clear_connections()
