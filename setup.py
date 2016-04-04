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


modules = ['math', 'vectors', 'input', 'graphics', 'shapes', 'time']

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
    remove_if_exist(os.path.join(source_path, module + '.cpp'))


extension = lambda name, files: Extension(
    'thor.' + name,
    sources=files,
    include_dirs=['include/Includes', 'include', '/usr/include'],
    language='c++',
    extra_compile_args = ['-std=c++11', '-fpermissive'],
    libraries=['sfml-system', 'sfml-window', 'sfml-graphics', 'sfml-audio', 'sfml-network', 'thor'])

math = extension(
	'math',
	['src/thor/math.pyx', 'src/thor/TrigonometricTraits.cpp'])

vectors = extension(
	'vectors',
	['src/thor/vectors.pyx'])

_input = extension(
	'input',
	['src/thor/input.pyx'])

graphics = extension(
	'graphics',
	['src/thor/graphics.pyx'])

shapes = extension(
	'shapes',
	['src/thor/shapes.pyx'])

time = extension(
	'time',
	['src/thor/time.pyx', 'src/thor/TimerFunctor.cpp'])

#extensions = [_input, time]
extensions = [math, vectors]

## Install C headers
#if platform.system() == 'Windows':
    ## On Windows: C:\Python27\include\pythor\*_api.h
    #c_headers = [(sys.exec_prefix +'\\include\\pythor', glob('include/pythor/*.h'))]
#else:
    ## On Unix: /usr/local/include/pythor/*_api.h
    #c_headers = [(sys.exec_prefix + '/include/pythor', glob('include/pythor/*.h'))]

#files = c_headers

with open('README.rst', 'r') as f:
    long_description = f.read()

kwargs = dict(
            name='pyThor',
            ext_modules=extensions,
            package_dir={'': 'src'},
            packages=['thor'],
            version='1.0.0',
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
