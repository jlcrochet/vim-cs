" Vim indent file
" Language: C#
" Author: Jeffrey Crochet <jlcrochet@pm.me>
" URL: github.com/jlcrochet/vim-cs

if get(b:, "did_indent")
  finish
endif

let b:did_indent = 1

setlocal indentexpr=GetCSIndent()

if exists("*GetCSIndent")
  finish
endif

let s:skip_delimiter = "synID(line('.'), col('.'), 1) != g:cs#highlighting#delimiter"

function GetCSIndent() abort
  " Do nothing if the current line is inside of a multiline region.
  let synid = synID(v:lnum, 1, 1)

  if synid == g:cs#highlighting#comment || synid == g:cs#highlighting#string
    return -1
  endif

  " If there is no previous line, return 0.
  let prev_lnum = prevnonblank(v:lnum - 1)

  if prev_lnum == 0
    return 0
  endif

  let prev_line = getline(prev_lnum)

  " If the previous line was a preprocessor directive or was inside of
  " a multiline region, find the nearest previous line that wasn't.
  let first_idx = match(prev_line, '\S')
  let first_char = prev_line[first_idx]
  let synid = synID(prev_lnum, 1, 1)

  while first_char ==# "#" || synid == g:cs#highlighting#comment || synid == g:cs#highlighting#string
    let prev_lnum = prevnonblank(prev_lnum - 1)

    if prev_lnum == 0
      return 0
    endif

    let prev_line = getline(prev_lnum)
    let first_idx = match(prev_line, '\S')
    let first_char = prev_line[first_idx]
    let synid = synID(prev_lnum, 1, 1)
  endwhile

  " If the previous line was an attribute line or a comment, align with
  " the previous line unless the current line begins with a closing
  " bracket.
  if first_char ==# "["
    call cursor(prev_lnum, first_idx + 1)

    if searchpair('\[', "", '\]', "z", s:skip_delimiter, prev_lnum)
      if getline(v:lnum) =~# '^\s*[)\]}]'
        return first_idx - shiftwidth()
      else
        return first_idx
      endif
    endif
  elseif first_char ==# "]"
    call cursor(prev_lnum, first_idx + 1)

    let [_, col] = searchpairpos('\[', "", '\]', "bW", s:skip_delimiter)

    if getline(v:lnum) =~# '^\s*[)\]}]'
      return col - 1 - shiftwidth()
    else
      return col - 1
    endif
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
