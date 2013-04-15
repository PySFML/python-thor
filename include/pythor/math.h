#ifndef __PYX_HAVE__thor__math
#define __PYX_HAVE__thor__math

struct PyDistributionObject;

/* "thor/math.pyx":18
 * from pysfml.system cimport to_vector2f
 * 
 * cdef public class Distribution[type PyDistributionType, object PyDistributionObject]:             # <<<<<<<<<<<<<<
 * 	cdef th.DistributionAPI *p_this
 * 
 */
struct PyDistributionObject {
  PyObject_HEAD
  ::DistributionAPI *p_this;
};

#ifndef __PYX_HAVE_API__thor__math

#ifndef __PYX_EXTERN_C
  #ifdef __cplusplus
    #define __PYX_EXTERN_C extern "C"
  #else
    #define __PYX_EXTERN_C extern
  #endif
#endif

__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyDistributionType;

#endif /* !__PYX_HAVE_API__thor__math */

#if PY_MAJOR_VERSION < 3
PyMODINIT_FUNC initmath(void);
#else
PyMODINIT_FUNC PyInit_math(void);
#endif

#endif /* !__PYX_HAVE__thor__math */
