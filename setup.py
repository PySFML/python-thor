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

from distutils.core import setup
from distutils.extension import Extension

# check if cython is needed (if c++ files are generated or not)
NEED_CYTHON = not all(map(os.path.exists, [
	'src/thor/animation.cpp',
	'src/thor/events.cpp',
	'src/thor/graphics.cpp',
	'src/thor/math.cpp',
	'src/thor/particles.cpp',
	'src/thor/resources.cpp',
	'src/thor/shapes.cpp',
	'src/thor/time.cpp',
	'src/thor/vectors.cpp']))

try:
	USE_CYTHON = NEED_CYTHON or bool(int(os.environ.get('USE_CYTHON', 0)))
except ValueError:
	USE_CYTHON = NEED_CYTHON or bool(os.environ.get('USE_CYTHON'))

if USE_CYTHON:
	try:
		from Cython.Distutils import build_ext
	except ImportError:
		from subprocess import call
		try:
			if platform.system() != 'Windows':
				call(["cython", "--cplus", "src/thor/animation.pyx", "-Iinclude"])
				call(["cython", "--cplus", "src/thor/events.pyx", "-Iinclude"])
				call(["cython", "--cplus", "src/thor/graphics.pyx", "-Iinclude"])
				call(["cython", "--cplus", "src/thor/math.pyx", "-Iinclude"])
				call(["cython", "--cplus", "src/thor/particles.pyx", "-Iinclude"])
				call(["cython", "--cplus", "src/thor/resources.pyx", "-Iinclude"])
				call(["cython", "--cplus", "src/thor/shapes.pyx", "-Iinclude"])
				call(["cython", "--cplus", "src/thor/time.pyx", "-Iinclude"])
				call(["cython", "--cplus", "src/thor/vectors.pyx", "-Iinclude"])
				USE_CYTHON = False
		except OSError:
			print("Please install the correct version of cython and run again.")
			sys.exit(1)

# define the include directory
if platform.system() == 'Windows':
	sfml_include = sys.prefix + "\\include\\pysfml\\"
else:
	major, minor, _, _ , _ = sys.version_info
	sfml_include = sys.prefix + "/include/python{0}.{1}/sfml/".format(major, minor)
	
if USE_CYTHON:
	file_extension = "pyx"
else:
	file_extension = "cpp"
	
modules = ['animation', 'events', 'math', 'particles', 'resources', 'shapes', 'time', 'vectors']
libraries = ['sfml-system', 'sfml-window', 'sfml-graphics', 'sfml-audio', 'sfml-network']

if USE_CYTHON:
	file_extension = ".pyx"
else:
	file_extension = ".cpp"
	
extension = lambda name: Extension(
	'thor.' + name,
	sources=["src/thor/" + name + file_extension],
	include_dirs=['include', sfml_include], 
	language='c++',
	extra_compile_args = ['--std=c++0x'],
	libraries=libraries+["thor"])

extensions = [extension(module) for module in modules]

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

if USE_CYTHON:
	kwargs['cmdclass'].update({'build_ext': build_ext})

setup(**kwargs)
