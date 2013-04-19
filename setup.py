#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pyThor - Python bindings for Thor
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

import sys, os, platform
import shutil
from subprocess import call
from distutils.core import setup, Extension

# check if cython is installed somewhere
try:
	raise ImportError
	from Cython.Distutils import build_ext as _build_ext
	CYTHON_AVAILABLE = True
except ImportError:
	# on unix platforms, check if cython isn't installed in another
	# python version, then compile manually
	if platform.system() == 'Linux':
		call('cython --cplus src/thor/graphics.pyx -Iinclude --fast-fail', shell=True)
		call('mv src/thor/graphics.h include/pythor', shell=True)
		call('mv src/thor/graphics_api.h include/pythor', shell=True)
		call('cython --cplus src/thor/events.pyx -Iinclude --fast-fail', shell=True)
		call('mv src/thor/events.h include/pythor', shell=True)
		call('cython --cplus src/thor/resources.pyx -Iinclude --fast-fail', shell=True)
		call('cython --cplus src/thor/shapes.pyx -Iinclude --fast-fail', shell=True)
		call('cython --cplus src/thor/math.pyx -Iinclude --fast-fail', shell=True)
		call('mv src/thor/math.h include/pythor', shell=True)
		call('cython --cplus src/thor/time.pyx -Iinclude --fast-fail', shell=True)
		call('cython --cplus src/thor/animation.pyx -Iinclude --fast-fail', shell=True)
		call('mv src/thor/animation.h include/pythor', shell=True)
		call('cython --cplus src/thor/particles.pyx -Iinclude --fast-fail', shell=True)
		call('mv src/thor/particles_api.h include/pythor', shell=True)
		call('cython --cplus src/thor/vectors.pyx -Iinclude --fast-fail', shell=True)

	from distutils.command import build_ext as _build_ext
	CYTHON_AVAILABLE = False

# check if cython is needed (if c++ files are generated or not)
sources = dict(
	animation = 'src/thor/animation.cpp',
	events = 'src/thor/events.cpp',
	resources = 'src/thor/resources.cpp',
	shapes = 'src/thor/shapes.cpp',
	math = 'src/thor/math.cpp',
	time = 'src/thor/time.cpp',
	graphics = 'src/thor/graphics.cpp',
	particles = 'src/thor/particles.cpp',
	vectors = 'src/thor/vectors.cpp')

NEED_CYTHON = not all(map(os.path.exists, sources.values()))

if NEED_CYTHON and not CYTHON_AVAILABLE:
	print("Please install cython and try again. Or use an official release with pre-generated source")
	raise SystemExit(1)

if CYTHON_AVAILABLE:
	class build_ext(_build_ext):
		""" Updated version of cython build_ext command to move
		the generated API headers to include/pythor directory
		"""

		def cython_sources(self, sources, extension):
			ret = _build_ext.cython_sources(self, sources, extension)

			# should result the module name; e.g, graphics[.pyx]
			module = os.path.basename(sources[0])[:-4]

			# move its headers (foo.h and foo_api.h) to include/pysfml
			destination = "include/pythor"

			source = "src/thor/{0}.h".format(module)
			if os.path.isfile(source):
				try:
					shutil.move(source, destination)
				except shutil.Error:
					pass

			source = "src/thor/{0}_api.h".format(module)
			if os.path.isfile(source):
				try:
					shutil.move(source, destination)
				except shutil.Error:
					pass

			return ret

sources = dict(
	animation = 'src/thor/animation.pyx',
	events = 'src/thor/events.pyx',
	resources = 'src/thor/resources.pyx',
	shapes = 'src/thor/shapes.pyx',
	math = 'src/thor/math.pyx',
	time = 'src/thor/time.pyx',
	graphics = 'src/thor/graphics.pyx',
	particles = 'src/thor/particles.pyx',
	vectors = 'src/thor/vectors.pyx')

if not CYTHON_AVAILABLE:
	sources = {k: v.replace('pyx', 'cpp') for k, v in sources.items()}

libs = ['sfml-system',
		'sfml-window',
		'sfml-graphics',
		'sfml-audio',
		'sfml-network',
		'thor']

extension = lambda name, files: Extension(
    'thor.' + name,
    sources=files,
    include_dirs=['include'],
    language='c++',
    extra_compile_args = ['--std=c++0x', '-fpermissive'],
    libraries=libs)

animation = extension(
	'animation',
	[sources['animation']])

events = extension(
	'events',
	[sources['events']])

resources = extension(
	'resources',
	[sources['resources']])

shapes = extension(
	'shapes',
	[sources['shapes']])

math = extension(
	'math',
	[sources['math'], 'src/thor/DistributionAPI.cpp'])

time = extension(
	'time',
	[sources['time'], 'src/thor/listeners.cpp'])

graphics = extension(
	'graphics',
	[sources['graphics'], 'src/thor/createGradient.cpp'])

particles_files = list()
particles_files.append(sources['particles'])
particles_files.append('src/thor/particles/DerivableAffector.cpp')
particles_files.append('src/thor/particles/DerivableEmitter.cpp')
particles_files.append('src/thor/particles/utilities.cpp')

particles = extension(
	'particles',
	particles_files)

vectors = extension(
	'vectors',
	[sources['vectors'], 'src/thor/vectors/PolarVector2Object.cpp'])

extensions = [graphics,
				events,
				resources,
				shapes,
				math,
				time,
				animation,
				particles,
				vectors]


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
            author='Jonathan de Wachter, Edwin Marshall',
            author_email='dewachter.jonathan@gmail.com, emarshall85@gmail.com',
            url='http://thor.python-sfml.org',
            license='LGPLv3',
            classifiers=['Development Status :: 5 - Production/Stable',
                        'Intended Audience :: Developers',
                        'License :: OSI Approved :: GNU Lesser General Public License v3 (LGPLv3)',
                        'Operating System :: OS Independent',
                        'Programming Language :: Cython',
                        'Programming Language :: C++',
                        'Programming Language :: Python',
                        'Topic :: Games/Entertainment',
                        'Topic :: Multimedia',
                        'Topic :: Software Development :: Libraries :: Python Modules'],
            cmdclass=dict())

if CYTHON_AVAILABLE:
	kwargs['cmdclass'].update({'build_ext': build_ext})

setup(**kwargs)
