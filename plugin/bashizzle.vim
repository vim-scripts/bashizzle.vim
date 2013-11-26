" {{{
" bashizzle.vim
" 
" a plugin which enables keyword replacement using bash, aka the macgyver-style of using snippets 
"
" Author : Leon van Kammen / Coder of Salvation 
" License: BSD 
"
" Comments welcome
" }}}
" ==========================================================================}}}
let g:bashizzle = "$HOME/.vim/bashizzle"

function! <SID>Run_Bashizzle() " {{{
  "let g:Keyword = substitute( getline("."),"^\\s\\+\\|\\s\\+$","","g")
  let g:Keyword = expand("<cword>")
  let g:File = expand("<cfile>")
  let $FILE = expand("%:t")
  let $CLASSNAME = expand("%:t:r")
  let $VIMBUFFER = join(getline(1,'$'), "\n")
  if filereadable( g:File )
    exe ":norm! dd"
    let isFilter = matchstr( g:File, ".filter" )
    if !empty(isFilter) " full text/replace if filter
      exe ":norm! ggdG" 
    endif
    exe ":.!" . g:bashizzle . " keyword " . g:File 
    return ""
  endif
  exe ":norm! daw"
  let s:_keyword_line     = line(".")
  let s:_keyword_pos      =  col(".")
  let output = system( g:bashizzle . " keyword " . g:Keyword )
  call complete(col('.'), split( output, '\n' ) )
  return ""
endfunction " }}}

function! <SID>Init_Bashizzle() " {{{
  exe "!" . g:bashizzle . " init "
endfunction " }}}

imap <C-B> <Plug>Run_Bashizzle
nmap <C-B> <Plug>Run_Bashizzle
imap <C-C> <Plug>Init_Bashizzle
nmap <C-C> <Plug>Init_Bashizzle
inoremap <silent> <script> <Plug>Run_Bashizzle <C-R>=<SID>Run_Bashizzle()<CR>
inoremap <silent> <script> <Plug>Init_Bashizzle <C-R>=<SID>Init_Bashizzle()<CR>
