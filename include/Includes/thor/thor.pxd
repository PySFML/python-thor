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

from libcpp.string cimport string
from sfml cimport *

################################################################################
# Math Module                                                                  #
################################################################################

cdef extern from "Thor/Math.hpp" namespace "thor":

    cdef cppclass Edge[V]:
        Edge(V&, V&)
        V operator[](size_t)
        const V operator[](size_t) const





#    cdef cppclass Triangle[V]:
#        Triangle(V&, V&, V&)
#        V& operator[](unsigned int)

#    int random(int, int)
#    int randomDev(int, int)
#    float random(float, float)
#    float randomDev(float, float)
#    void setRandomSeed(unsigned long)

#cdef extern from "Thor/Math.hpp" namespace "thor":

#    cdef cppclass Distribution[T]:
#        Distribution(T)
#        T operator ()()

#cdef extern from "DistributionAPI.hpp" namespace "":

#    cdef cppclass DistributionAPI:
#        object operator ()()
#        Distribution[float]    getFloatFunctor()
#        Distribution[Vector2f] getVector2Functor()
#        Distribution[Time]     getTimeFunctor()
#        Distribution[Color]    getColorFunctor()

#    cdef cppclass DistributionObject:
#        DistributionObject(object)

#        Distribution[float]    getFloatFunctor()
#        Distribution[Vector2f] getVector2Functor()
#        Distribution[Time]     getTimeFunctor()
#        Distribution[Color]    getColorFunctor()

#    cdef cppclass DistributionFloat:
#        DistributionFloat(Distribution[float])

#        Distribution[float]    getFloatFunctor()
#        Distribution[Vector2f] getVector2Functor()
#        Distribution[Time]     getTimeFunctor()
#        Distribution[Color]    getColorFunctor()

#    cdef cppclass DistributionVector2:
#        DistributionVector2(Distribution[Vector2f])

#        Distribution[float]    getFloatFunctor()
#        Distribution[Vector2f] getVector2Functor()
#        Distribution[Time]     getTimeFunctor()
#        Distribution[Color]    getColorFunctor()

#    cdef cppclass DistributionTime:
#        DistributionTime(Distribution[Time])

#        Distribution[float]    getFloatFunctor()
#        Distribution[Vector2f] getVector2Functor()
#        Distribution[Time]     getTimeFunctor()
#        Distribution[Color]    getColorFunctor()

#    cdef cppclass DistributionColor:
#        DistributionColor(Distribution[Color])

#        Distribution[float]    getFloatFunctor()
#        Distribution[Vector2f] getVector2Functor()
#        Distribution[Time]     getTimeFunctor()
#        Distribution[Color]    getColorFunctor()

#cimport distributions

################################################################################
# Vectors Module                                                               #
################################################################################
cdef extern from "Thor/Vectors.hpp" namespace "thor":
    cdef cppclass PolarVector2[T]:
        PolarVector2()
        PolarVector2(T, T)
        PolarVector2(const Vector2[T]&)
#        operator sf::Vector2< T > () const
        T r
        T phi

    ctypedef PolarVector2[float] PolarVector2f

#    cdef T length[T](const Vector2[T]&)
#    cdef T length[T](const Vector3[T]&)
#    cdef T length[T](const PolarVector2[T]&)

#    cdef T squaredLength[T](const Vector2[T]&)
#    cdef T squaredLength[T](const Vector3[T]&)

#    cdef void setLength[T](Vector2[T]&, T)

#    cdef Vector2[T] unitVector[T](const Vector2[T]&)
#    cdef Vector3[T] unitVector[T](const Vector3[T]&)

#    cdef T polarAngle[T](const Vector2[T]&)
#    cdef T polarAngle[T](const Vector3[T]&)
#    cdef T polarAngle[T](const PolarVector2[T]&)

#    cdef void setPolarAngle[T](Vector2[T]&, T)

#    cdef void rotate[T](Vector2[T]&, T)
#    cdef Vector2[T] rotatedVector[T](const Vector2[T]&, T)
#    cdef Vector2[T] perpendicularVector[T](const Vector2[T]&)

#    cdef T signedAngle[T](const Vector2[T]&, const Vector2[T]&)

#    cdef T dotProduct[T](const Vector2[T]&, const Vector2[T]&)
#    cdef T dotProduct[T](const Vector3[T]&, const Vector3[T]&)

#    cdef T crossProduct[T](const Vector2[T]&, const Vector2[T]&)
#    cdef Vector3[T] crossProduct[T](const Vector3[T]&, const Vector3[T]&)

#    cdef Vector2[T] cwiseProduct[T](const Vector2[T]&, const Vector2[T]&)
#    cdef Vector3[T] cwiseProduct[T](const Vector3[T]&, const Vector3[T]&)

#    cdef Vector2[T] cwiseQuotient[T](const Vector2[T]&, const Vector2[T]&)
#    cdef Vector3[T] cwiseQuotient[T](const Vector3[T]&, const Vector3[T]&)

#    cdef Vector2[T] projectedVector[T](const Vector2[T]&, const Vector2[T]&)
#    cdef T elevationAngle[T](const Vector3[T]&)
#    cdef Vector3[T] toVector3[T](const Vector2[T]&)


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


################################################################################
# Input module                                                                 #
################################################################################
cdef extern from "Thor/Input.hpp" namespace "thor":

    cdef cppclass Connection:
        Connection()
        bint isConnected() const
        void invalidate()
        void disconnect()

################################################################################
# Graphics module                                                              #
################################################################################
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
        Color sampleColor(float)

    Color blendColors(const Color&, const Color&, float)

################################################################################
# Shapes module                                                                #
################################################################################
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
        void setColor(Color&)
        Color getColor() const
        void setStyle(arrow.Style)
        arrow.Style getStyle() const

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

#################################################################################
## Animation Module                                                             #
#################################################################################
#cdef extern from "Thor/Animation.hpp" namespace "thor":

#    cdef cppclass FrameAnimation:
#        FrameAnimation()
#        void addFrame(float, IntRect&)

#    cdef cppclass ColorAnimation:
#        ColorAnimation(ColorGradient&)

#    cdef cppclass FadeAnimation:
#        FadeAnimation(float, float)

#    cdef cppclass Animator[Animated, Id]:
#        Animator()
#        void addAnimation(Id&, FrameAnimation&, Time)
#        void addAnimation(Id&, ColorAnimation&, Time)
#        void addAnimation(Id&, FadeAnimation&, Time)
#        void playAnimation(Id&)
#        void playAnimation(Id&, bint)
#        void stopAnimation()
#        bint isPlayingAnimation()
#        void update(Time)
#        void animate(Animated&)


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

################################################################################
# Time Module                                                                  #
################################################################################
cdef extern from "Thor/Time.hpp" namespace "thor":

    cdef cppclass CallbackTimer:
        CallbackTimer()
        void reset(Time)
        void restart(Time)
        void update()
#        Connection connect(std::function< void(CallbackTimer &)> unaryListener)
#        Connection connect0(std::function< void()> nullaryListener)
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

    cdef cppclass Timer:
        Timer()
        Time getRemainingTime() const
        bint isRunning() const
        bint isExpired() const
        void start()
        void stop()
        void reset(Time)
        void restart(Time)
