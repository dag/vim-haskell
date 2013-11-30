if exists('b:did_ftplugin')
  finish
else
  let b:did_ftplugin = 1
endif

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | setlocal'
else
  let b:undo_ftplugin = 'setlocal'
endif

setlocal iskeyword=@,48-57,_,'
let b:undo_ftplugin .= ' iskeyword<'

let &l:include = haskell#Regex('^ import \s* %(qualified)= \s*')
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=.hs,.lhs,.hsc,.hsx,hs,lhs,hsc,hsx
let b:undo_ftplugin .= ' include< includeexpr< suffixesadd<'

setlocal comments=f-1:{-#,s1:{-,mb:-,ex:-},b:--
let &l:commentstring = '-- %s'
let b:undo_ftplugin .= ' comments< commentstring<'

setlocal formatoptions+=croql
setlocal formatoptions-=t
silent! setlocal formatoptions+=j
let b:undo_ftplugin .= ' formatoptions<'

nnoremap <silent> <buffer> [[ :<C-u>call haskell#Section(1)<CR>
nnoremap <silent> <buffer> ]] :<C-u>call haskell#Section(0)<CR>
