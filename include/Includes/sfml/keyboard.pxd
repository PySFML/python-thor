#-------------------------------------------------------------------------------
# PySFML - Python bindings for SFML
# Copyright (c) 2012-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#                          Edwin Marshall <emarshall85@gmail.com>
#
# This software is provided 'as-is', without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from the
# use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software in a
#    product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
#
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
#
# 3. This notice may not be removed or altered from any source distribution.
#-------------------------------------------------------------------------------

cdef extern from "SFML/Window.hpp" namespace "sf::Keyboard":
    cdef enum Key:
        Unknown
        A
        B
        C
        D
        E
        F
        G
        H
        I
        J
        K
        L
        M
        N
        O
        P
        Q
        R
        S
        T
        U
        V
        W
        X
        Y
        Z
        Num0
        Num1
        Num2
        Num3
        Num4
        Num5
        Num6
        Num7
        Num8
        Num9
        Escape
        LControl
        LShift
        LAlt
        LSystem
        RControl
        RShift
        RAlt
        RSystem
        Menu
        LBracket
        RBracket
        SemiColon
        Comma
        Period
        Quote
        Slash
        BackSlash
        Tilde
        Equal
        Dash
        Space
        Return
        BackSpace
        Tab
        PageUp
        PageDown
        End
        Home
        Insert
        Delete
        Add
        Subtract
        Multiply
        Divide
        Left
        Right
        Up
        Down
        Numpad0
        Numpad1
        Numpad2
        Numpad3
        Numpad4
        Numpad5
        Numpad6
        Numpad7
        Numpad8
        Numpad9
        F1
        F2
        F3
        F4
        F5
        F6
        F7
        F8
        F9
        F10
        F11
        F12
        F13
        F14
        F15
        Pause
        KeyCount

    bint isKeyPressed(Key)
    void setVirtualKeyboardVisible(bint)
