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


#include "createGradient.hpp"
#include "Thor/Graphics.hpp"
#include <SFML/Graphics.hpp>
#include "pysfml/graphics.h"
#include "graphics.h"
#include "pysfml/graphics_api.h"
#include "graphics_api.h"

PyObject* createGradientFromList(PyObject* list)
{
	// the following code assumes the list content has been checked before
	import_thor__graphics();

	Py_ssize_t i, n;
    n = PyList_Size(list);

    if (n < 0)
        return NULL;

	PyColorObject* color = (PyColorObject*)PyList_GetItem(list, 0);

	thor::detail::ColorGradientConvertible temp_conv = thor::createGradient(*color->p_this);
	thor::detail::ColorGradientTransition* temp_trans;

	PyColorObject* tempColor   = NULL;
	float tempInteger = 0;

    bool isColor = false;

    for (i = 1; i < n; i++)
    {

		if (isColor)
		{
			tempColor = (PyColorObject*)PyList_GetItem(list, i);
			temp_conv = (*temp_trans)(*tempColor->p_this);
		}
		else
		{
			tempInteger = PyFloat_AsDouble(PyList_GetItem(list, i));
			temp_trans = &temp_conv(tempInteger);
		}

        isColor = !isColor;
	}

	thor::ColorGradient* finalColor = new thor::ColorGradient(temp_conv);
	return wrap_colorgradient(finalColor);
}
