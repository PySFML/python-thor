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

from libcpp.sfml cimport Vector2, Vector3
from libcpp.sfml cimport Vector2u, Vector2f
from libcpp.sfml cimport Time
from libcpp.sfml cimport IntRect, FloatRect
from libcpp.sfml cimport Color
from libcpp.sfml cimport Image, Texture
from libcpp.sfml cimport Shape, ConvexShape

################################################################################
# Vectors Module                                                               #
################################################################################
cdef extern from "Thor/Vectors.hpp" namespace "thor":
    cdef cppclass PolarVector2[T]:
        PolarVector2()
        PolarVector2(T, T)

cdef extern from "vectors/PolarVector2Object.hpp" namespace "":
    cdef cppclass PolarVector2Object:
        PolarVector2Object()
        PolarVector2Object(object, object)
        object radius()
        void   radius(object)
        object angle()
        void   angle(object)

cdef extern from "Thor/Vectors.hpp" namespace "thor":
    object length(Vector2&)

#cdef extern from "Thor/Vectors.hpp" namespace "thor":
    ##object length(Vector2[object]&)
    #object squaredLength(Vector2[object]&)
    #void setLength(Vector2[object]&, object)
    #Vector2[object] unitVector(Vector2[object]&)
    ##object polarAngle(Vector2[object]&)
    #void setPolarAngle(Vector2[object]&, object)
    #void rotate(Vector2[object]&, object)
    #Vector2[object] rotatedVector(Vector2[object]&, object)
    #Vector2[object] perpendicularVector(Vector2[object]&)
    #object signedAngle(Vector2[object]&, Vector2[object]&)
    #object dotProduct(Vector2[object]&, Vector2[object]&)
    #Vector3[object] crossProduct(Vector2[object]&, Vector2[object]&)
    #Vector2[object] componentwiseProduct(Vector2[object]&, Vector2[object]&)
    #Vector2[object] componentwiseQuotient(Vector2[object]&, Vector2[object]&)

    ##object length(Vector3[object]&)
    #object squaredLength(Vector3[object]&)
    #Vector3[object] unitVector(Vector3[object]&)
    ##object polarAngle(Vector3[object]&)
    #object elevationAngle(Vector3[object]&)
    #object dotProduct(Vector3[object]&, Vector3[object]&)
    #Vector3[object] crossProduct(Vector3[object]&, Vector3[object]&)
    #Vector3[object] componentwiseProduct(Vector3[object]&, Vector3[object]&)
    #Vector3[object] componentwiseQuotient(Vector3[object]&, Vector3[object]&)
    #Vector3[object] toVector3(Vector2[object]&)

    #object length(PolarVector2Object&)
    #object polarAngle(PolarVector2Object&)

################################################################################
# Event module                                                                 #
################################################################################
cdef extern from "Thor/Events.hpp" namespace "thor":

    cdef cppclass Connection:
        Connection()
        bint isConnected()
        void invalidate()
        void disconnect()

################################################################################
# Graphics module                                                              #
################################################################################
cdef extern from "Thor/Graphics.hpp" namespace "thor":

    cdef cppclass BigTexture:
        BigTexture()
        void swap(BigTexture&)
        bint loadFromImage(Image&)
        bint loadFromFile(char*&)
        bint loadFromMemory(char*, size_t)
        #bint loadFromStream(InputStream&)
        Vector2u getSize()

    cdef cppclass BigSprite:
        BigSprite()
        BigSprite(BigTexture&)
        void setTexture(BigTexture&)
        void setColor(Color&)
        Color getColor()
        FloatRect getLocalBounds()
        FloatRect getGlobalBounds()

    cdef cppclass ColorGradient:
        ColorGradient(Color&)
        Color getColor(float)

    Color blendColors(Color&, Color&, float)

cdef extern from "createGradient.hpp" namespace "":
    object createGradientFromList(object)


################################################################################
# Shapes module                                                                #
################################################################################

cdef extern from "Thor/Shapes.hpp" namespace "thor":

    cdef cppclass Arrow:
        Arrow()
        Arrow(Vector2f)
        Arrow(Vector2f, Vector2f)
        Arrow(Vector2f, Vector2f, Color&)
        Arrow(Vector2f, Vector2f, Color&, float)
        void setDirection(Vector2f)
        void setDirection(float, float)
        Vector2f getDirection()
        void setThickness(float)
        float getThickness()
        void setColor(Color&)
        Color getColor()

    cdef cppclass ConcaveShape:
        ConcaveShape()
        ConcaveShape(Shape&)
        void swap(ConcaveShape&)
        void setPointCount(unsigned int)
        unsigned int getPointCount()
        void setPoint(unsigned int, Vector2f)
        Vector2f getPoint(unsigned int)
        void setFillColor(Color&)
        void setOutlineColor(Color&)
        Color getFillColor()
        Color getOutlineColor()
        void setOutlineThickness(float)
        float getOutlineThickness()

    void swap(ConcaveShape&, ConcaveShape&)


cdef extern from "Thor/Shapes.hpp" namespace "thor::Shapes":

    ConvexShape toConvexShape(Shape&)

    ConvexShape line(Vector2f, Color&)
    ConvexShape line(Vector2f, Color&, float)

    ConvexShape roundedRect(Vector2f, float, Color&)
    ConvexShape roundedRect(Vector2f, float, Color&, float)
    ConvexShape roundedRect(Vector2f, float, Color&, float, Color&)

    ConvexShape polygon(unsigned int, float, Color&)
    ConvexShape polygon(unsigned int, float, Color&, float)
    ConvexShape polygon(unsigned int, float, Color&, float, Color&)

    ConvexShape star(unsigned int, float, float, Color&)
    ConvexShape star(unsigned int, float, float, Color&, float)
    ConvexShape star(unsigned int, float, float, Color&, float, Color&)

    ConcaveShape pie(float, float, Color&)
    ConcaveShape pie(float, float, Color&, float)
    ConcaveShape pie(float, float, Color&, float, Color&)

cimport arrow

################################################################################
# Math Module                                                                  #
################################################################################
cdef extern from "Thor/Math.hpp" namespace "thor":

    cdef cppclass Distribution[T]:
        Distribution(T)
        T operator ()()

cdef extern from "DistributionAPI.hpp" namespace "":

    cdef cppclass DistributionAPI:
        object operator ()()
        Distribution[float]    getFloatFunctor()
        Distribution[Vector2f] getVector2Functor()
        Distribution[Time]     getTimeFunctor()
        Distribution[Color]    getColorFunctor()

    cdef cppclass DistributionObject:
        DistributionObject(object)

        Distribution[float]    getFloatFunctor()
        Distribution[Vector2f] getVector2Functor()
        Distribution[Time]     getTimeFunctor()
        Distribution[Color]    getColorFunctor()

    cdef cppclass DistributionFloat:
        DistributionFloat(Distribution[float])

        Distribution[float]    getFloatFunctor()
        Distribution[Vector2f] getVector2Functor()
        Distribution[Time]     getTimeFunctor()
        Distribution[Color]    getColorFunctor()

    cdef cppclass DistributionVector2:
        DistributionVector2(Distribution[Vector2f])

        Distribution[float]    getFloatFunctor()
        Distribution[Vector2f] getVector2Functor()
        Distribution[Time]     getTimeFunctor()
        Distribution[Color]    getColorFunctor()

    cdef cppclass DistributionTime:
        DistributionTime(Distribution[Time])

        Distribution[float]    getFloatFunctor()
        Distribution[Vector2f] getVector2Functor()
        Distribution[Time]     getTimeFunctor()
        Distribution[Color]    getColorFunctor()

    cdef cppclass DistributionColor:
        DistributionColor(Distribution[Color])

        Distribution[float]    getFloatFunctor()
        Distribution[Vector2f] getVector2Functor()
        Distribution[Time]     getTimeFunctor()
        Distribution[Color]    getColorFunctor()

cdef extern from "Thor/Math.hpp" namespace "thor":

    int random(int, int)
    int randomDev(int, int)
    float random(float, float)
    float randomDev(float, float)
    void setRandomSeed(unsigned long)

    cdef cppclass Edge[V]:
        Edge(V&, V&)
        V operator[](unsigned int)

    cdef cppclass Triangle[V]:
        Triangle(V&, V&, V&)
        V& operator[](unsigned int)

cimport distributions

################################################################################
# Animation Module                                                             #
################################################################################
cdef extern from "Thor/Animation.hpp" namespace "thor":

    cdef cppclass FrameAnimation:
        FrameAnimation()
        void addFrame(float, IntRect&)

    cdef cppclass ColorAnimation:
        ColorAnimation(ColorGradient&)

    cdef cppclass FadeAnimation:
        FadeAnimation(float, float)

    cdef cppclass Animator[Animated, Id]:
        Animator()
        void addAnimation(Id&, FrameAnimation&, Time)
        void addAnimation(Id&, ColorAnimation&, Time)
        void addAnimation(Id&, FadeAnimation&, Time)
        void playAnimation(Id&)
        void playAnimation(Id&, bint)
        void stopAnimation()
        bint isPlayingAnimation()
        void update(Time)
        void animate(Animated&)


################################################################################
# Particles Module                                                             #
################################################################################
cdef extern from "<memory>" namespace "std":
    cdef cppclass shared_ptr[T]:
        shared_ptr()
        shared_ptr(T* ptr)
        T* get()
        long use_count()


cdef extern from "Thor/Particles.hpp" namespace "thor":
    cdef cppclass Particle:
        Particle(Time)
        Vector2f position
        Vector2f velocity
        float rotation
        float rotationSpeed
        Vector2f scale
        Color color

    cdef Time getPassedLifetime(Particle&)
    cdef Time getTotalLifetime(Particle&)
    cdef Time getRemainingLifetime(Particle&)
    cdef float getPassedRatio(Particle&)
    cdef float getRemainingRatio(Particle&)

    cdef cppclass Affector
    cdef cppclass Emitter

cimport emitter, affector

cdef extern from "Thor/Particles.hpp" namespace "thor":
    cdef cppclass ParticleSystem:
        ParticleSystem(shared_ptr[Texture])
        ParticleSystem(shared_ptr[Texture], IntRect&)
        void swap(ParticleSystem&)
        void addAffector(shared_ptr[Affector])
        void addAffector(shared_ptr[Affector], Time)
        void removeAffector(shared_ptr[Affector])
        void clearAffectors()
        bint containsAffector(shared_ptr[Affector])
        void addEmitter(shared_ptr[Emitter])
        void addEmitter(shared_ptr[Emitter], Time)
        void removeEmitter(shared_ptr[Emitter])
        void clearEmitters()
        bint containsEmitter(shared_ptr[Emitter])
        void update(Time)
        void clearParticles()

cdef extern from "particles/DerivableEmitter.hpp" namespace "":
    cdef cppclass DerivableEmitter:
        DerivableEmitter(object)

cdef extern from "particles/DerivableAffector.hpp" namespace "":
    cdef cppclass DerivableAffector:
        DerivableAffector(object)

cimport derivableemitter, derivableaffector

cdef extern from "Thor/Particles.hpp" namespace "thor":
    cdef cppclass UniversalEmitter:
        UniversalEmitter()
        void setEmissionRate(float)
        void setParticleLifetime(Distribution[Time])
        void setParticlePosition(Distribution[Vector2f])
        void setParticleVelocity(Distribution[Vector2f])
        void setParticleRotation(Distribution[float])
        void setParticleRotationSpeed(Distribution[float])
        void setParticleScale(Distribution[Vector2f])
        void setParticleColor(Distribution[Color])

cimport universalemitter


cdef extern from "Thor/Particles.hpp" namespace "thor":
    cdef cppclass ForceAffector:
        ForceAffector(Vector2f)
        void affect(Particle&, Time)
        Vector2f getAcceleration()
        void setAcceleration(Vector2f)

    cdef cppclass ScaleAffector:
        ScaleAffector(Vector2f)
        void affect(Particle&, Time)
        Vector2f getScaleFactor()
        void setScaleFactor(Vector2f)

    cdef cppclass TorqueAffector:
        TorqueAffector(float)
        void affect(Particle&, Time)
        void setAngularAcceleration(float)
        float getAngularAcceleration()

    cdef cppclass AnimationAffector

cimport torqueaffector, scaleaffector, forceaffector, animationaffector

cdef extern from "particles/utilities.hpp":
    emitter.Ptr castUniversalEmitter(universalemitter.Ptr)

    affector.Ptr castAnimationAffector(animationaffector.Ptr)
    affector.Ptr castTorqueAffector(torqueaffector.Ptr)
    affector.Ptr castScaleAffector(scaleaffector.Ptr)
    affector.Ptr castForceAffector(forceaffector.Ptr)

################################################################################
# Time Module                                                                  #
################################################################################
cdef extern from "Python.h" namespace "":
    void PyEval_InitThreads()

cdef extern from "Thor/Time.hpp" namespace "thor":

    cdef cppclass Timer:
        Timer()
        Time getRemainingTime()
        bint isRunning()
        bint isExpired()
        void start()
        void stop()
        void reset(Time)
        void restart(Time)

    cdef cppclass CallbackTimer:
        CallbackTimer()
        void update() nogil
        # see "CallbackTimer_connect" for Connection connect(Listener&)
        void clearConnections()

    cdef cppclass StopWatch:
        StopWatch()
        Time getElapsedTime()
        bint isRunning()
        void start()
        void stop()
        void reset()
        void restart()

cdef extern from "listeners.hpp" namespace "":
    Connection CallbackTimer_connect(CallbackTimer*, object)
