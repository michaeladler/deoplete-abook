scriptencoding utf-8

" Copyright (c) 2017 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

function! s:check_addressbook() abort
  let datafile = get(g:, 'deoplete#sources#abook#datafile',
        \ expand('~/.abook/addressbook'))
  if filereadable(datafile)
    call health#report_ok('Addressbook file found: ' . datafile)
  else
    call health#report_error('Addressbook file not found',
          \ ['help: deoplete_abook.txt'])
  endif
endfunction

function! health#deoplete_abook#check() abort
  call health#report_start('deoplete-abook')
  call s:check_addressbook()
endfunction

" vim: ts=2 et sw=2
