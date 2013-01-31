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


#include "particles/utilities.hpp"

thor::Emitter::Ptr castUniversalEmitter(thor::UniversalEmitter::Ptr ptr)
{
	return std::static_pointer_cast<thor::Emitter>(ptr);
}

thor::Affector::Ptr castAnimationAffector(thor::AnimationAffector::Ptr ptr)
{
	return std::static_pointer_cast<thor::Affector>(ptr);
}

thor::Affector::Ptr castTorqueAffector(thor::TorqueAffector::Ptr ptr)
{
	return std::static_pointer_cast<thor::Affector>(ptr);
}

thor::Affector::Ptr castScaleAffector(thor::ScaleAffector::Ptr ptr)
{
	return std::static_pointer_cast<thor::Affector>(ptr);
}

thor::Affector::Ptr castForceAffector(thor::ForceAffector::Ptr ptr)
{
	return std::static_pointer_cast<thor::Affector>(ptr);
}
