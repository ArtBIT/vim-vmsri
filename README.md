.. Copyright (c) 2012 - 2014, 
   Aggelos Orfanakos, Djordje Ungar
   All rights reserved.

   Redistribution and use of this software in source and binary forms, with
   or without modification, are permitted provided that the following
   conditions are met:

   * Redistributions of source code must retain the above
     copyright notice, this list of conditions and the
     following disclaimer.

   * Redistributions in binary form must reproduce the above
     copyright notice, this list of conditions and the
     following disclaimer in the documentation and/or other
     materials provided with the distribution.

   * Neither the name of Eric Van Dewoestine nor the names of its
     contributors may be used to endorse or promote products derived from
     this software without specific prior written permission of
     Eric Van Dewoestine.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
   PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

.. _overview:

==================
Overview
==================

VMSRI is a vim plugin which allows you to quickly open deviantART VMS Resource Identifiers.

Features
--------
 There is a number of keystrokes that mirror the `gf` family of keystrokes, that open a VMSRI
 instead of a filepath.
  - `gv` - opens a VMSRI in current buffer
  - `gV` - opens a VMSRI and jumps to a function call
  - `<C-W>v` - opens a VMSRI in a split window
  - `<C-W>V` - opens a VMSRI in a split window and jumps to a call
  - `<C-W>gv` - opens a VMSRI in a new tab
  - `<C-W>gV` - opens a VMSRI in a new tab and jumps to a call

Installation
------------
There are several plugin managers for vim, which will either allow you to
manually clone vim plugin repositories, or will do so for you. Probably the
two most popular ones currently are `pathogen
<https://github.com/tpope/vim-pathogen>`_ and `vundle
<https://github.com/gmarik/Vundle.vim>`_. Please refer to their docs for
instructions on how to install plugins.
