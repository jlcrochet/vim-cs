" Vim autoload file
" Language: C#
" Author: Jeffrey Crochet <jlcrochet91@pm.me>
" URL: https://github.com/jlcrochet/vim-cs

const g:cs#syntax#hl = #{
    \ comment: hlID("csComment"),
    \ comment_start: hlID("razorcsCommentStart"),
    \ comment_end: hlID("csCommentEnd"),
    \ string: hlID("csString"),
    \ string_end: hlID("csStringEnd"),
    \ attribute_delimiter: hlID("csAttributeDelimiter")
    \ }
