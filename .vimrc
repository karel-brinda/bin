"
" LINKS
" =====
" - http://nvie.com/posts/how-i-boosted-my-vim/
"
"






source $HOME/bin/vim/vim-sensible/plugin/sensible.vim

" source $VIMRUNTIME/mswin.vim
if has("clipboard")
    " CTRL-X is Cut
    vnoremap <C-X> "+x

    " CTRL-C is Copy
    vnoremap <C-C> "+y

    " CTRL-V is Paste
    map <C-V>		"+gP
    cmap <C-V>		<C-R>+
endif

"""""""""""""""""""""
" Use Enter as Esc,
" Shift+Enter in insert mode = multiline mode
"""""""""""""""""""""
:inoremap <CR> <Esc>
function! ToggleEnterMapping()
  if empty(mapcheck('<CR>', 'i'))
    inoremap <CR> <Esc>`^
    return "\<Esc>"
  else
    iunmap <CR>
    return "\<CR>"
  endif
endfunction
call ToggleEnterMapping()
inoremap <expr> <S-CR> ToggleEnterMapping()
" Optional (so <CR> cancels prefix, selection, operator).
nnoremap <CR> <Esc>
vnoremap <CR> <Esc>gV
onoremap <CR> <Esc>
"""""""""""""""""""""

colo torte

set guifont=Hack:h11

au BufNewFile,BufRead Snakefile set syntax=python
filetype plugin indent on

syntax on
filetype indent plugin on
set modeline
set number

" allow aliases
:set shellcmdflag=-ic

map <f9> :w<CR>:! make<CR>

augroup python_files
    autocmd!
    autocmd FileType python setlocal noexpandtab
    autocmd FileType python set tabstop=4
    autocmd FileType python set shiftwidth=4
    autocmd BufWritePre * %s/\s\+$//e
augroup END



"""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/bin/vim/bundle/vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
Plugin 'stephpy/vim-yaml'

call vundle#end()            " required
filetype plugin indent on    " required
