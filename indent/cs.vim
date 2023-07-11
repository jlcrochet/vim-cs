" Vim indent file
" Language: C#
" Author: Jeffrey Crochet <jlcrochet91@pm.me>
" URL: https://github.com/jlcrochet/vim-cs

if get(b:, "did_indent")
  finish
endif

let b:did_indent = 1

setlocal
      \ indentexpr=GetCSIndent()
      \ cinoptions+=j1

if exists("*GetCSIndent")
  finish
endif

let s:skip_attribute_delimiter = "synID(line('.'), col('.'), 0) != g:cs#syntax#hl.attribute_delimiter"

function s:is_multiline(id) abort
  let hl = g:cs#syntax#hl

  return
      \ a:id == hl.comment ||
      \ a:id == hl.comment_end ||
      \ a:id == hl.string ||
      \ a:id == hl.string_end
endfunction

function GetCSIndent() abort
  " Do nothing if the current line is inside of a multiline region.
  let id = synID(v:lnum, 1, 0)

  if s:is_multiline(id)
    return -1
  endif

  " If there is no previous line, return 0.
  let prev_lnum = prevnonblank(v:lnum - 1)

  if prev_lnum == 0
    return 0
  endif

  " If the previous line was a preprocessor directive or was inside of
  " a multiline region, find the nearest previous line that wasn't.
  let start_lnum = prev_lnum
  let start_line = getline(start_lnum)
  let [first_char, _, first_col] = start_line->matchstrpos('\S')

  while first_char ==# '#' || s:is_multiline(synID(start_lnum, 1, 0))
    let start_lnum = prevnonblank(start_lnum - 1)

    if start_lnum == 0
      return 0
    endif

    let start_line = getline(start_lnum)
    let [first_char, _, first_col] = start_line->matchstrpos('\S')
  endwhile

  " If the previous line was an attribute line or a comment, align with
  " the previous line.
  if first_char ==# '['
    if synID(start_lnum, first_col, 0) == g:cs#syntax#hl.attribute_delimiter
      call cursor(start_lnum, first_col)

      if searchpair('\[', '', ']', "z", s:skip_attribute_delimiter, start_lnum)
        return indent(start_lnum)
      endif
    endif
  elseif first_col ==# ']'
    if synID(start_lnum, first_col, 0) == g:cs#syntax#hl.attribute_delimiter
      return indent(start_lnum)
    endif
  elseif first_char ==# '/'
    let second_char = start_line[first_col]

    if (second_char ==# '/' || second_char ==# '*') && synID(start_lnum, first_col, 0) == g:cs#syntax#hl.comment_start
      return indent(start_lnum)
    endif
  endif

  " Otherwise, fall back to C indentation.
  "
  " TODO: In the future, this should probably be replaced with custom
  " logic.
  return cindent(v:lnum)
endfunction
