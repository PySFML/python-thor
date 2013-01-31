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


#ifndef PYTHOR_DERIVABLEEMITTER_HPP
#define PYTHOR_DERIVABLEEMITTER_HPP

#include "Python.h"
#include <memory>
#include <SFML/System.hpp>
#include <Thor/Particles.hpp>

class DerivableEmitter : public thor::Emitter
{
public :
	static thor::Emitter::Ptr create(PyObject*);

	DerivableEmitter(PyObject*);

	void emit(thor::Emitter::Adder &system, sf::Time dt);

	PyObject* object;
};


#endif // PYTHOR_DERIVABLEEMITTER_HPP
