from libcpp.string cimport string
from sfml cimport *

# Math Module Declarations
cdef extern from "../math/Distribution.hpp":
    cdef cppclass Function:
        pass

cdef extern from "Thor/Math.hpp" namespace "thor":

    cdef cppclass Distribution[T]:
        Distribution(T) # wrong, this is to allow constant (but parameter should be U)
        Distribution(Function)

        T operator ()()

    cdef cppclass Edge[V]:
        Edge(V&, V&)
        V& operator[] (size_t)

    cdef cppclass Triangle[V]:
        Triangle(V&, V&, V&)
        V& operator[] (size_t)

    int random(int, int)
    unsigned int random(unsigned int, unsigned int)
    float random(float, float)
    float randomDev(float, float)
    void setRandomSeed(unsigned long)

    object toDegree(object)
    object toRadian(object)

    cdef const float Pi

cimport distributions

# Vectors Module Declarations
cdef extern from "Thor/Vectors.hpp" namespace "thor":
    cdef cppclass PolarVector2[T]:
        PolarVector2()
        PolarVector2(T, T)
        PolarVector2(const Vector2[T]&)
        T r
        T phi

    ctypedef PolarVector2[float] PolarVector2f

    cdef T length[T](const Vector2[T]&)
    cdef T length[T](const Vector3[T]&)
    cdef T length[T](const PolarVector2[T]&)

    cdef T squaredLength[T](const Vector2[T]&)
    cdef T squaredLength[T](const Vector3[T]&)

    cdef void setLength[T](Vector2[T]&, T)

    cdef Vector2[T] unitVector[T](const Vector2[T]&)
    cdef Vector3[T] unitVector[T](const Vector3[T]&)

    cdef T polarAngle[T](const Vector2[T]&)
    cdef T polarAngle[T](const Vector3[T]&)
    cdef T polarAngle[T](const PolarVector2[T]&)

    cdef void setPolarAngle[T](Vector2[T]&, T)

    cdef void rotate[T](Vector2[T]&, T)
    cdef Vector2[T] rotatedVector[T](const Vector2[T]&, T)
    cdef Vector2[T] perpendicularVector[T](const Vector2[T]&)

    cdef T signedAngle[T](const Vector2[T]&, const Vector2[T]&)

    cdef T dotProduct[T](const Vector2[T]&, const Vector2[T]&)
    cdef T dotProduct[T](const Vector3[T]&, const Vector3[T]&)

    cdef T crossProduct[T](const Vector2[T]&, const Vector2[T]&)
    cdef Vector3[T] crossProduct[T](const Vector3[T]&, const Vector3[T]&)

    cdef Vector2[T] cwiseProduct[T](const Vector2[T]&, const Vector2[T]&)
    cdef Vector3[T] cwiseProduct[T](const Vector3[T]&, const Vector3[T]&)

    cdef Vector2[T] cwiseQuotient[T](const Vector2[T]&, const Vector2[T]&)
    cdef Vector3[T] cwiseQuotient[T](const Vector3[T]&, const Vector3[T]&)

    cdef Vector2[T] projectedVector[T](const Vector2[T]&, const Vector2[T]&)
    cdef T elevationAngle[T](const Vector3[T]&)
    cdef Vector3[T] toVector3[T](const Vector2[T]&)

# Input Module Declarations
cimport action

cdef extern from "Thor/Input.hpp" namespace "thor":

    cdef cppclass JoystickButton:
        JoystickButton(unsigned int, unsigned int)
        unsigned int joystickId
        unsigned int button

    cdef cppclass JoystickAxis:
        JoystickAxis(unsigned int, joystick.Axis, float, bint)
        unsigned int joystickId
        joystick.Axis axis
        float threshold
        bint above

    cdef cppclass Action:
        Action(keyboard.Key)
        Action(keyboard.Key, action.ActionType)
        Action(mouse.Button)
        Action(mouse.Button, action.ActionType)
        Action(JoystickButton)
        Action(JoystickButton, action.ActionType)
        Action(JoystickAxis)
        Action(event.EventType)

    cdef cppclass ActionMap[ActionId]:
        ActionMap()
        void update(Window&)
        void pushEvent(const Event&)
        void clearEvents()
        Action& operator[] (const ActionId&)
        void removeAction(const ActionId&)
        void clearActions()
        bint isActive(const ActionId&) const
#        void invokeCallbacks (CallbackSystem &system, sf::Window *window) const

    cdef cppclass Connection:
        pass
#        Connection()
#        bint isConnected() const
#        void invalidate()
#        void disconnect()

    cdef cppclass EventSystem[Event, EventId]:
        EventSystem()
        void triggerEvent(const Event&)
#        Connection connect(const EventId&, std::function<void(const Event &)>)
#        Connection connect0(const EventId&, std::function< void()> nullaryListener)
        void clearConnections(EventId)
        void clearAllConnections()

# Time Module Declarations
cdef extern from "Thor/Time.hpp" namespace "thor":

    cdef cppclass Timer:
        Timer()
        Time getRemainingTime() const
        bint isRunning() const
        bint isExpired() const
        void start()
        void stop()
        void reset(Time)
        void restart(Time)

    cdef cppclass CallbackTimer:
        CallbackTimer()
        void reset(Time)
        void restart(Time)
        void update()
#        Connection connect(std::function< void(CallbackTimer &)> unaryListener)
#        Connection connect0 (std::function< void()> nullaryListener)
        void clearConnections()
        Time getRemainingTime() const
        bint isRunning() const
        bint isExpired() const
        void start()
        void stop()

    cdef cppclass StopWatch:
        StopWatch()
        Time getElapsedTime() const
        bint isRunning() const
        void start()
        void stop()
        void reset()
        void restart()

# Resources Module Declarations

cdef extern from "../resources/Resource.hpp":
    cdef cppclass ResourceLoaderFunction:
        ResourceLoaderFunction(object)

cimport dresources

cdef extern from "Thor/Resources.hpp" namespace "thor":

    cdef cppclass ResourceLoader[R]:
        ResourceLoader(ResourceLoaderFunction, string)
#        R load() const
        string getInfo() const

    cdef cppclass ResourceHolder[R, I, O]:
        ResourceHolder()
#        RT acquire(const I&, cosnt ResourceLoader[R]&)
#        RT acquire(const I&, cosnt ResourceLoader[R]&, dresources.KnownIdStrategy)
        void release(const I&)
#        RT operator[](const I&)

# Graphics Module Declarations
cdef extern from "Thor/Graphics.hpp" namespace "thor":

    cdef cppclass BigTexture:
        BigTexture()
        bint loadFromImage(const Image&)
        bint loadFromFile(const char*& filename)
        bint loadFromMemory(const void*, size_t)
        bint loadFromStream(InputStream&)
        Vector2u getSize() const
        void setSmooth(bint)
        bint isSmooth() const

    cdef cppclass BigSprite:
        BigSprite()
        BigSprite(const BigTexture&)
        void setTexture(const BigTexture&)
        void setColor(const Color&)
        Color getColor() const
        FloatRect getLocalBounds() const
        FloatRect getGlobalBounds() const

    cdef cppclass ColorGradient:
        ColorGradient()
        Color& operator[](float)
        Color sampleColor(float) const

    Color blendColors(const Color&, const Color&, float)

# Shapes Module Declarations
cimport arrow, dshapes

cdef extern from "Thor/Shapes.hpp" namespace "thor":

    cdef cppclass Arrow:
        Arrow()
        Arrow(Vector2f)
        Arrow(Vector2f, Vector2f)
        Arrow(Vector2f, Vector2f, const Color&)
        Arrow(Vector2f, Vector2f, const Color&, float)
        void setDirection(Vector2f)
        void setDirection(float, float)
        Vector2f getDirection() const
        void setThickness(float)
        float getThickness() const
        void setColor(const Color&)
        Color getColor() const
        void setStyle(arrow.Style)
        arrow.Style getStyle() const

        @staticmethod
        void setZeroVectorTolerance(float)
        @staticmethod
        float getZeroVectorTolerance()

    cdef cppclass ConcaveShape:
        ConcaveShape()
        ConcaveShape(const Shape&)
        void setPointCount(size_t)
        size_t getPointCount() const
        void setPoint(size_t, Vector2f)
        Vector2f getPoint(size_t) const
        void setFillColor(const Color&)
        void setOutlineColor(const Color&)
        Color getFillColor() const
        Color getOutlineColor() const
        void setOutlineThickness(float)
        float getOutlineThickness() const
        FloatRect getLocalBounds() const
        FloatRect getGlobalBounds() const

# Animations Module Declarations
cdef extern from "../animations/AnimationFunction.hpp":
    cdef cppclass AnimationFunction:
        AnimationFunction(object)

    cdef cppclass ColorizableObject:
        ColorizableObject(object)

    cdef cppclass FramableObject:
        FramableObject(object)

cdef extern from "Thor/Animations.hpp" namespace "thor":

    cdef cppclass ColorAnimation:
#        ColorAnimation(ColorGradient&)
        void operator() (ColorizableObject&, float) const

    cdef cppclass FadeAnimation:
        FadeAnimation(float, float)
        void operator() (ColorizableObject&, float) const

    cdef cppclass FrameAnimation:
        FrameAnimation()
        void addFrame(float, const IntRect&)
        void addFrame(float, const IntRect&, Vector2f)
        void operator() (FramableObject&, float) const

    cdef cppclass Animator[Animated, Id]:
        Animator()
        Animator(const Animator&)
        void addAnimation(const Id&, const AnimationFunction&, Time)
        void playAnimation(const Id&)
        void playAnimation(const Id&, bint)
        void stopAnimation()
        bint isPlayingAnimation() const
        Id getPlayingAnimation() const
        void update(Time)
        void animate(Animated&) const

#################################################################################
## Particles Module                                                             #
#################################################################################
#cdef extern from "<memory>" namespace "std":
#    cdef cppclass shared_ptr[T]:
#        shared_ptr()
#        shared_ptr(T* ptr)
#        T* get()
#        long use_count()


#cdef extern from "Thor/Particles.hpp" namespace "thor":
#    cdef cppclass Particle:
#        Particle(Time)
#        Vector2f position
#        Vector2f velocity
#        float rotation
#        float rotationSpeed
#        Vector2f scale
#        Color color

#    cdef Time getPassedLifetime(Particle&)
#    cdef Time getTotalLifetime(Particle&)
#    cdef Time getRemainingLifetime(Particle&)
#    cdef float getPassedRatio(Particle&)
#    cdef float getRemainingRatio(Particle&)

#    cdef cppclass Affector
#    cdef cppclass Emitter

#cimport emitter, affector

#cdef extern from "Thor/Particles.hpp" namespace "thor":
#    cdef cppclass ParticleSystem:
#        ParticleSystem(shared_ptr[Texture])
#        ParticleSystem(shared_ptr[Texture], IntRect&)
#        void swap(ParticleSystem&)
#        void addAffector(shared_ptr[Affector])
#        void addAffector(shared_ptr[Affector], Time)
#        void removeAffector(shared_ptr[Affector])
#        void clearAffectors()
#        bint containsAffector(shared_ptr[Affector])
#        void addEmitter(shared_ptr[Emitter])
#        void addEmitter(shared_ptr[Emitter], Time)
#        void removeEmitter(shared_ptr[Emitter])
#        void clearEmitters()
#        bint containsEmitter(shared_ptr[Emitter])
#        void update(Time)
#        void clearParticles()

#cdef extern from "particles/DerivableEmitter.hpp" namespace "":
#    cdef cppclass DerivableEmitter:
#        DerivableEmitter(object)

#cdef extern from "particles/DerivableAffector.hpp" namespace "":
#    cdef cppclass DerivableAffector:
#        DerivableAffector(object)

#cimport derivableemitter, derivableaffector

#cdef extern from "Thor/Particles.hpp" namespace "thor":
#    cdef cppclass UniversalEmitter:
#        UniversalEmitter()
#        void setEmissionRate(float)
#        void setParticleLifetime(Distribution[Time])
#        void setParticlePosition(Distribution[Vector2f])
#        void setParticleVelocity(Distribution[Vector2f])
#        void setParticleRotation(Distribution[float])
#        void setParticleRotationSpeed(Distribution[float])
#        void setParticleScale(Distribution[Vector2f])
#        void setParticleColor(Distribution[Color])

#cimport universalemitter


#cdef extern from "Thor/Particles.hpp" namespace "thor":
#    cdef cppclass ForceAffector:
#        ForceAffector(Vector2f)
#        void affect(Particle&, Time)
#        Vector2f getAcceleration()
#        void setAcceleration(Vector2f)

#    cdef cppclass ScaleAffector:
#        ScaleAffector(Vector2f)
#        void affect(Particle&, Time)
#        Vector2f getScaleFactor()
#        void setScaleFactor(Vector2f)

#    cdef cppclass TorqueAffector:
#        TorqueAffector(float)
#        void affect(Particle&, Time)
#        void setAngularAcceleration(float)
#        float getAngularAcceleration()

#    cdef cppclass AnimationAffector

#cimport torqueaffector, scaleaffector, forceaffector, animationaffector

#cdef extern from "particles/utilities.hpp":
#    emitter.Ptr castUniversalEmitter(universalemitter.Ptr)

#    affector.Ptr castAnimationAffector(animationaffector.Ptr)
#    affector.Ptr castTorqueAffector(torqueaffector.Ptr)
#    affector.Ptr castScaleAffector(scaleaffector.Ptr)
#    affector.Ptr castForceAffector(forceaffector.Ptr)
