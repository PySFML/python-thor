import sys, os, platform
import shutil
from glob import glob
from subprocess import call
from distutils.core import setup, Extension

try:
    from Cython.Distutils import build_ext
except ImportError:
    print("Please install cython and try again.")
    raise SystemExit

if platform.architecture()[0] == "32bit":
	arch = "x86"
elif platform.architecture()[0] == "64bit":
	arch = "x64"

class CythonBuildExt(build_ext):
    """ Updated version of cython build_ext command to move
    the generated API headers to include/pythor directory
    """

    def cython_sources(self, sources, extension):
        ret = build_ext.cython_sources(self, sources, extension)

        # should result the module name; e.g, graphics[.pyx]
        module = os.path.basename(sources[0])[:-4]

        # move its headers (foo.h and foo_api.h) to include/pythor
        destination = os.path.join('include', 'pythor')

        source = os.path.join('src', 'thor', module + '.h')
        if os.path.isfile(source):
            try:
                shutil.move(source, destination)
            except shutil.Error:
                pass

        source = os.path.join('src', 'thor', module + '_api.h')
        if os.path.isfile(source):
            try:
                shutil.move(source, destination)
            except shutil.Error:
                pass

        return ret

modules = ['math', 'vectors', 'input', 'time', 'resources', 'graphics', 'shapes', 'animations', 'shapes']

# clean the directory (remove generated C++ files by Cython)
def remove_if_exist(filename):
    if os.path.isfile(filename):
        try:
            os.remove(filename)
        except OSError:
            pass

include_path = os.path.join('include', 'pythor')
source_path = os.path.join('src', 'thor')

for module in modules:
    remove_if_exist(os.path.join(include_path, module + '.h'))
    remove_if_exist(os.path.join(include_path, module + '._api.h'))
    remove_if_exist(os.path.join(source_path, module, module + '.cpp'))
    remove_if_exist(os.path.join(source_path, module, module + '.h'))
    remove_if_exist(os.path.join(source_path,module,  module + '._api.h'))

extension = lambda name, files: Extension(
    'thor.' + name,
    sources=['src/thor/' + name + '/' + filename for filename in files],
    include_dirs=['/home/sonkun/Workspace/python-sfml/include/Includes', 'include/Includes', 'include', 'src/thor/' + name],
    language='c++',
    extra_compile_args = ['-std=c++11'],
    libraries=['sfml-system', 'sfml-window', 'sfml-graphics', 'sfml-audio', 'sfml-network', 'thor'])


modules = ['math', 'vectors', 'input', 'time', 'resources', 'graphics', 'shapes', 'animations', 'shapes']

math = extension('math', ['math.pyx', 'Vertex.cpp', 'Triangulation.cpp', 'Rule.cpp', 'Distribution.cpp'])
vectors = extension('vectors', ['vectors.pyx', 'PolarVector2.cpp'])
vectors.extra_link_args.append('/usr/local/lib/python3.4/dist-packages/sfml/system.cpython-34m.so')
vectors.extra_link_args.append('-Wl,-rpath,'+'/usr/local/lib/python3.4/dist-packages/sfml/')

input_ = extension('input', ['input.pyx', 'Input.cpp'])
time = extension('time', ['time.pyx', 'Listener.cpp', 'DerivableTimer.cpp'])

resources = extension('resources', ['resources.pyx', 'Resource.cpp'])

graphics = extension('graphics', ['graphics.pyx'])
shapes = extension('shapes', ['shapes.pyx'])

animations = extension('animations', ['animations.pyx', 'Object.cpp', 'AnimationFunction.cpp'])
particles = extension('particles', ['particles.pyx'])

#extensions = [math, vectors, input_, time, resources, graphics, shapes, animations, shapes]
extensions = [math, vectors, time, graphics, shapes]

with open('README.rst', 'r') as f:
    long_description = f.read()

kwargs = dict(
            name='pyThor',
            ext_modules=extensions,
            package_dir={'': 'src'},
            packages=['thor'],
            version='2.0.0',
            description='Python bindings for Thor',
            long_description=long_description,
            author='Jonathan de Wachter',
            author_email='dewachter.jonathan@gmail.com',
            url='http://thor.python-sfml.org',
            classifiers=['Development Status :: 5 - Production/Stable',
                        'Intended Audience :: Developers',
                        'License :: OSI Approved :: zlib/libpng License',
                        'Operating System :: OS Independent',
                        'Programming Language :: Cython',
                        'Programming Language :: C++',
                        'Programming Language :: Python',
                        'Topic :: Games/Entertainment',
                        'Topic :: Multimedia',
                        'Topic :: Software Development :: Libraries :: Python Modules'],
            cmdclass={'build_ext': CythonBuildExt})

setup(**kwargs)
