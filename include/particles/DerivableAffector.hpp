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


#ifndef PYTHOR_DERIVABLEAFFECTOR_HPP
#define PYTHOR_DERIVABLEAFFECTOR_HPP

#include "Python.h"
#include <memory>
#include <SFML/System.hpp>
#include <Thor/Particles.hpp>


class DerivableAffector : public thor::Affector
{
public :
	static thor::Affector::Ptr create(PyObject*);

	DerivableAffector(PyObject*);
	~DerivableAffector();

	void affect(thor::Particle& particle, sf::Time dt);

	PyObject* object;
};


#endif // PYTHOR_DERIVABLEAFFECTOR_HPP
