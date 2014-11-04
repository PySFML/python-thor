//------------------------------------------------------------------------------
// PyThor - Python bindings for Thor
// Copyright (c) 2013-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
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

#ifndef PYTHOR_UTILITIES_HPP
#define PYTHOR_UTILITIES_HPP

#include <memory>
#include <Thor/Particles.hpp>

thor::Emitter::Ptr castUniversalEmitter(thor::UniversalEmitter::Ptr);

thor::Affector::Ptr castAnimationAffector(thor::AnimationAffector::Ptr);
thor::Affector::Ptr castTorqueAffector(thor::TorqueAffector::Ptr);
thor::Affector::Ptr castScaleAffector(thor::ScaleAffector::Ptr);
thor::Affector::Ptr castForceAffector(thor::ForceAffector::Ptr);

#endif // PYTHOR_UTILITIES_HPP
