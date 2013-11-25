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
let g:pendingfile = 0

function! <SID>Run_Bashizzle() " {{{
        "let g:Keyword = substitute( getline("."),"^\\s\\+\\|\\s\\+$","","g")
        let g:Keyword = expand("<cword>")
        let g:File = expand("<cfile>")
        if filereadable( g:File )
          exe ":norm! dd"
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


imap <C-B> <Plug>Run_Bashizzle
nmap <C-B> <Plug>Run_Bashizzle
inoremap <silent> <script> <Plug>Run_Bashizzle <C-R>=<SID>Run_Bashizzle()<CR>
