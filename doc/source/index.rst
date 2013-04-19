Python bindings for Thor
========================
This is version **0.9alpha** of the Python bindings for `Thor`_, based on
the latest `pySFML`_ version (*latest_sfml* branch) and is made
available under the terms of the `LGPLv3`_ license.

This is a **work-in-progress** and that's why you'll find missing features
and the following sections may be incomplete. See
:doc:`TODO list </todolist>` section for more details.

So far, no documentation is provided, please refer to examples.

These bindings were created in large part by **Jonathan De Wachter**, with
significant contributions from **Edwin Marshall**.

Table of Contents
=================

.. hlist::
   :columns: 2


   * .. glossary::

      :doc:`gettingstarted`
         A gentle introduction to these bindings, covering some basic
         principles.

   * .. glossary::

      :doc:`download`
         Instructions on where and how to install these bindings for various
         platforms. Includes information on how to compile them from source.

   * .. glossary::

      :doc:`examples`
         Practical examples demonstrating how various parts of this binding can
         work together with each other as well as other APIs.

   * .. glossary::

      :doc:`tutorials`
         Tutorials focusing on the various core principles integral to
         understanding how Thor works.

   * .. glossary::

      :doc:`api/index`
         Complete library reference organized by each of the binding's nine
         core modules.

Progress
========
Module Implementation States:

- Time, particle, animation, graphics and shapes modules **are implemented**.
- Vector and math modules are **partially** implemented
- Events and resources modules are **not** implemented.

Most of the Thor functionalities have been implemented but sometimes are
incomplete (quick implementation):

- So far, Animator support animation sf.Sprite only
- Function to add callbacks should support \*args


.. _Thor: http://www.bromeon.ch/libraries/thor/
.. _pySFML: http://www.python-sfml.org/1.3
.. _LGPLv3: http://www.gnu.org/copyleft/lgpl.html
