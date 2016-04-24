#
# PyThor - Python bindings for Thor
# Copyright (c) 2013-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#

"""
    Mathematical functionality, such as random number generator or
    trigonometric wrappers.
"""

__all__ = ['Resources', 'ResourceLoadingException', 'ResourceAccessException',
    'ResourceHolder', 'ResourceLoader']

from libcpp.string cimport string

cimport sfml as sf
cimport thor as th

cdef extern from "Input.hpp":

    cdef cppclass Identifier:
        Identifier(object)
        object get()

    cdef cppclass Resource:
        Object()
        object get()

    object loadResource(th.ResourceLoader[Resource]*)

    object acquireResource(th.ResourceHolder[Resource, Identifier, th.dresources.RefCounted]* resourceHolder, Identifier, th.ResourceLoader[Resource]*, th.dresources.KnownIdStrategy)
    object getResource(th.ResourceHolder[Resource, Identifier, th.dresources.RefCounted]* resourceHolder, Identifier)

    th.ResourceLoader[Resource]* heinFromFile(object, const string filename)

class ResourceLoadingException(Exception):
    pass

class ResourceAccessException(Exception):
    pass

cdef class ResourceLoader:
    cdef th.ResourceLoader[Resource]* p_this

#    def __cinit__(self, loader, id_):
    def __init__(self, loader, id_):
        self.p_this = new th.ResourceLoader[Resource](th.ResourceLoaderFunction(loader), id_)

    def __dealloc__(self):
        del self.p_this

    def load(self):
        return loadResource(self.p_this)

    property info:
        def __get__(self):
            return self.p_this.getInfo()

cdef api object wrap_resource_loader(th.ResourceLoader[Resource]* p):
    cdef ResourceLoader r = ResourceLoader.__new__(ResourceLoader)
    r.p_this = p
    return r

class Resources:

    @staticmethod
    def from_file(type_, filename):
        cdef th.ResourceLoader[Resource]* p
        p = heinFromFile(type_, filename)

        return wrap_resource_loader(p)
#        p = fromFile(type_, filename)
#        return wrap_resource_loader(p)

#    @staticmethod
#    def from_memory(param1, param2):
#        pass

class KnownIdStrategy:
    ASSUME_NEW = th.dresources.AssumeNew
    REUSE = th.dresources.Reuse
    RELOAD = th.dresources.Reload

cdef class ResourceHolder:
    cdef th.ResourceHolder[Resource, Identifier, th.dresources.RefCounted]* p_this

    def __cinit__(self):
        self.p_this = new th.ResourceHolder[Resource, Identifier, th.dresources.RefCounted]()

    def __dealloc__(self):
        del self.p_this

    def __getitem__(self, key):
        return getResource(self.p_this, Identifier(key))

    def acquire(self, id_, ResourceLoader how, th.dresources.KnownIdStrategy known):
        return acquireResource(self.p_this, Identifier(id_), how.p_this, known)

    def release(self, id_):
        self.p_this.release(Identifier(id_))
