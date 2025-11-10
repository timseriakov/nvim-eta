" Vim syntax file for Eta templates
" Language: Eta (Embedded JavaScript Templates)
" Maintainer: nvim-eta
" Latest Revision: 2025

if exists("b:current_syntax")
  finish
endif

" Load HTML syntax as base
runtime! syntax/html.vim
unlet! b:current_syntax

" Eta template delimiters
syn region etaScriptlet matchgroup=etaDelimiter start="<%\s*" end="\s*%>" contains=@htmlJavaScript,etaComment
syn region etaOutput matchgroup=etaDelimiter start="<%=\s*" end="\s*%>" contains=@htmlJavaScript
syn region etaEscape matchgroup=etaDelimiter start="<%~\s*" end="\s*%>" contains=@htmlJavaScript
syn region etaComment start="<%#" end="%>" contains=etaCommentTodo
syn region etaRaw matchgroup=etaDelimiter start="<%_\s*" end="\s*%>" contains=@htmlJavaScript

" Special keywords and operators within Eta tags
syn keyword etaKeyword if else elif for while do break continue return contained
syn keyword etaOperator typeof instanceof new delete in of contained

" Comment highlighting
syn keyword etaCommentTodo TODO FIXME XXX NOTE contained

" Define highlight groups
hi def link etaDelimiter Delimiter
hi def link etaComment Comment
hi def link etaCommentTodo Todo
hi def link etaKeyword Keyword
hi def link etaOperator Operator

let b:current_syntax = "eta"

