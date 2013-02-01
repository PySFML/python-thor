////////////////////////////////////////////////////////////////////////////////
//
// pyThor - Python bindings for Thor
// Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//
// This software is released under the LGPLv3 license.
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////


#ifndef PYTHOR_UTILITIES_HPP
#define PYTHOR_UTILITIES_HPP

#include <memory>
#include <SFML/Graphics.hpp>
#include <Thor/Particles.hpp>

//std::shared_ptr<sf::Texture> makeTextureShared(sf::Texture*);

thor::Emitter::Ptr castUniversalEmitter(thor::UniversalEmitter::Ptr);

thor::Affector::Ptr castAnimationAffector(thor::AnimationAffector::Ptr);
thor::Affector::Ptr castTorqueAffector(thor::TorqueAffector::Ptr);
thor::Affector::Ptr castScaleAffector(thor::ScaleAffector::Ptr);
thor::Affector::Ptr castForceAffector(thor::ForceAffector::Ptr);

#endif // PYTHOR_UTILITIES_HPP
