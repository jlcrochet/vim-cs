" Vim indent file
" Language: C#
" Author: Jeffrey Crochet <jlcrochet91@pm.me>
" URL: https://github.com/jlcrochet/vim-cs

if get(b:, 'did_indent')
  finish
endif

let b:did_indent = 1

setlocal
    \ indentexpr=GetCsIndent()
    \ cinoptions+=j1

if exists('*GetCsIndent')
  finish
endif

let s:skip_delimiter = "synID(line('.'), col('.'), 0)->synIDattr('name') !=? 'csDelimiter'"

function s:syn_name_at(lnum, col)
  return synID(a:lnum, a:col, 0)->synIDattr('name')
endfunction

function s:is_multiline(name)
  return a:name =~? '^cs\%(Comment\|String\)\%(End\)\=$'
endfunction

function GetCsIndent() abort
  " If there is no previous line, return 0.
  let prev_lnum = prevnonblank(v:lnum - 1)

  if prev_lnum == 0
    return 0
  endif

  let syngroup = s:syn_name_at(v:lnum, 1)

  " Do nothing if the current line is inside of a multiline region.
  if s:is_multiline(syngroup)
    return -1
  endif

  " If the previous line was a preprocessor directive or was inside of
  " a multiline region, find the nearest previous line that wasn't.
  let start_lnum = prev_lnum
  let start_line = getline(start_lnum)
  let [first_char, _, first_col] = start_line->matchstrpos('\S')

  while first_char ==# '#' || s:is_multiline(s:syn_name_at(start_lnum, 1))
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
    if s:syn_name_at(start_lnum, first_col) ==? 'csDelimiter'
      call cursor(start_lnum, first_col)

      if searchpair('\[', '', ']', 'z', s:skip_delimiter, start_lnum)
        return indent(start_lnum)
      endif
    endif
  elseif first_col ==# ']'
    if s:syn_name_at(start_lnum, first_col) ==? 'csDelimiter'
      return indent(start_lnum)
    endif
  endif

  " Otherwise, fall back to standard C indentation.
  return cindent(v:lnum)
endfunction
