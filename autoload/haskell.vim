function! haskell#Section(backwards)
  let l:id = hlID('haskellVars')
  let l:lnum = line('.') + (a:backwards ? -1 : 1)
  while a:backwards ? l:lnum > 0 : l:lnum <= line('$')
    if getline(l:lnum) =~# '^\S' && synID(l:lnum, 1, 1) ==# l:id
      execute l:lnum
      break
    endif
    let l:lnum += a:backwards ? -1 : 1
  endwhile
endfunction
