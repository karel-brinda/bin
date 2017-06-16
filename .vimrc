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

    set list
    set listchars=tab:▸\ ,eol:¬
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

set relativenumber
set undofile
let mapleader = ","

" fix regex
nnoremap / /\v
vnoremap / /\v

" search highlighting
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" match bracket pairs using tab
nnoremap <tab> %
vnoremap <tab> %

" screen line instead of file line
nnoremap j gj
nnoremap k gk

" get rid of F1=help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" ; := :
nnoremap ; :

"" leader
" strip all lines
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" reformat paragraphs
nnoremap <leader>q gqip

" split window and jump there
nnoremap <leader>w <C-w>v<C-w>l

" skip between windows
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
