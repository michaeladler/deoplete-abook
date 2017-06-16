scriptencoding utf-8

" Copyright (c) 2017 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

if exists('g:loaded_deoplete_abook')
  finish
endif
let g:loaded_deoplete_abook = 1

if !exists('g:deoplete_abook_datafile')
  let g:deoplete_abook_datafile = expand('~/.abook/addressbook')
endif

" vim: ts=2 et sw=2
