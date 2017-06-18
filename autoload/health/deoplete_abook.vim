scriptencoding utf-8

" Copyright (c) 2017 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

function! s:check_deoplete() abort
  if !empty(globpath(&runtimepath, 'plugin/deoplete.vim'))
    call health#report_ok('Deoplete plugin is installed')
  else
    call health#report_error('Deoplete plugin is not installed', [
          \ 'The deoplete plugin can be found here: ' .
          \ 'https://github.com/Shougo/deoplete.nvim'
          \ ])
  endif
endfunction

function! s:check_addressbook() abort
  let datafile = get(g:, 'deoplete#sources#abook#datafile',
        \ expand('~/.abook/addressbook'))
  if filereadable(datafile)
    call health#report_ok('Addressbook file was found: ' . datafile)
  else
    call health#report_error('Addressbook file was not found',
          \ ['help: deoplete_abook.txt'])
  endif
endfunction

function! health#deoplete_abook#check() abort
  call health#report_start('Dependencies')
  call s:check_deoplete()
  call s:check_addressbook()
endfunction

" vim: ts=2 et sw=2
