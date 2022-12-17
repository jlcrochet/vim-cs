" Vim indent file
" Language: C#
" Author: Jeffrey Crochet <jlcrochet91@pm.me>
" URL: github.com/jlcrochet/vim-cs

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

let s:skip_attribute_delimiter = "synID(line('.'), col('.'), 0)->synIDattr('name') !=# 'csAttributeDelimiter'"

function GetCSIndent() abort
  " Do nothing if the current line is inside of a multiline region.
  let syngroup = synID(v:lnum, 1, 0)->synIDattr("name")

  if syngroup =~# '^cs\%(Comment\|String\)\%(End\)\=$'
    return -1
  endif

  " If there is no previous line, return 0.
  let prev_lnum = prevnonblank(v:lnum - 1)

  if prev_lnum == 0
    return 0
  endif

  " If the current line begins with a closing bracket, use
  " C indentation.
  if getline(v:lnum) =~# '^\s*[)\]}]'
    return cindent(v:lnum)
  endif

  " If the previous line was a preprocessor directive or was inside of
  " a multiline region, find the nearest previous line that wasn't.
  let prev_line = getline(prev_lnum)
  let first_idx = match(prev_line, '\S')
  let first_char = prev_line[first_idx]
  let syngroup = synID(prev_lnum, 1, 0)->synIDattr("name")

  while first_char ==# "#" || syngroup =~# '^cs\%(Comment\|String\)\%(End\)\=$'
    let prev_lnum = prevnonblank(prev_lnum - 1)

    if prev_lnum == 0
      return 0
    endif

    let prev_line = getline(prev_lnum)
    let first_idx = match(prev_line, '\S')
    let first_char = prev_line[first_idx]
    let syngroup = synID(prev_lnum, 1, 0)->synIDattr("name")
  endwhile

  " If the previous line was an attribute line or a comment, align with
  " the previous line.
  if first_char ==# "["
    call cursor(prev_lnum, first_idx + 1)

    if searchpair('\[', "", '\]', "z", s:skip_attribute_delimiter, prev_lnum)
      return first_idx
    endif
  elseif first_char ==# "]"
    call cursor(prev_lnum, first_idx + 1)

    let [_, col] = searchpairpos('\[', "", '\]', "bW", s:skip_attribute_delimiter)

    return col - 1
  elseif first_char ==# "/"
    let second_char = prev_line[first_idx + 1]

    if second_char ==# "/" || second_char ==# "*"
      return first_idx
    endif
  endif

  " Otherwise, fall back to C indentation.
  "
  " TODO: In the future, this should probably be replaced with custom
  " logic.
  return cindent(v:lnum)
endfunction
