
set omnifunc=syntaxcomplete#Complete
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "set rtp+=" . g:opamshare . "/merlin/vimbufsync"
execute "set rtp+=/home/mateusz/misc/syntastic/"
let g:syntastic_ocaml_checkers = ['merlin']
execute "set rtp+=/home/mateusz/misc/vim-slime/"
au FileType ocaml setlocal expandtab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
"execute ":source /home/mateusz/misc/ocaml.vim"
set mouse=a
set number
"Ignore fact that a buffer has been modified while switching between buffers
set hidden
"execute "set rtp+=/home/mateusz/misc/powerline/powerline/bindings/vim/"
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256
"execute "set rtp+=/home/mateusz/misc/vim-colors/solarized/"
syntax enable
set background=dark
colorscheme solarized
execute "set rtp+=/home/mateusz/misc/ctrlp.vim/"
execute "set rtp+=/home/mateusz/misc/nerdtree/"
nmap <C-t> :NERDTree<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>
execute pathogen#infect()
let mapleader=","

au BufEnter *.ml setf ocaml
au BufEnter *.mli setf ocaml
au FileType ocaml call FT_ocaml()
function FT_ocaml()
    set textwidth=80
    set colorcolumn=80
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    " ocp-indent with ocp-indent-vim
    let opamshare=system("opam config var share | tr -d '\n'")
    execute "autocmd FileType ocaml source".opamshare."/vim/syntax/ocp-indent.vim"
    filetype indent on
    filetype plugin indent on
endfunction

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

filetype plugin indent on
au BufRead,BufNewFile *.php setfiletype php
autocmd FileType php setlocal expandtab
autocmd FileType php setlocal shiftwidth=4
autocmd FileType php setlocal tabstop=4
autocmd FileType php setlocal softtabstop=4
au BufRead,BufNewFile *.html set filetype=html
au BufRead,BufNewFile *.twig set filetype=html
autocmd FileType html setlocal expandtab
autocmd FileType html setlocal shiftwidth=2
autocmd FileType html setlocal tabstop=2
autocmd FileType html setlocal softtabstop=2

"let g:ycm_global_ycm_extra_conf = "/home/mateusz/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:clang_user_options='|| exit 0'

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
:command WQ wq
:command W w
:command Wq wq
:command Q q
nnoremap j gj
nnoremap k gk
"nnoremap <C-j> <C-F>
"nnoremap <C-k> <C-B>
"nnoremap <C-l> <C-D>
"nnoremap <C-k> <C-U>
