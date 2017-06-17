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


"colorscheme elford

set guifont=Hack:h11

syntax on
filetype indent plugin on
set modeline
set number

" allow aliases
:set shellcmdflag=-ic

map <f9> :w<CR>:! make<CR>




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

"set relativenumber
set undofile
let mapleader = ","

" fix regex
" nnoremap / /\v
" #vnoremap / /\v

" search highlighting
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

nnoremap <leader>r :w<cr> \| :so %<cr>

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

" smart matching
set ignorecase
set smartcase

"" Other tips
nnoremap ' `
nnoremap ` '

set title


""" https://hashrocket.com/blog/posts/8-great-vim-mappings

" Change tabs
noremap <S-l> gt
noremap <S-h> gT

" Change panes
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

set hidden
set history=1000
set wildmenu
set wildmode=list:longest
set scrolloff=3


iab kg karel.brinda@gmail.com

iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor



au BufNewFile,BufRead Snakefile set syntax=python
filetype plugin indent on

augroup python_files
	autocmd!
	autocmd FileType python setlocal noexpandtab
	autocmd FileType python set tabstop=4
	autocmd FileType python set shiftwidth=4
	autocmd BufWritePre * %s/\s\+$//e

	set list
	set listchars=tab:▸\ ,eol:¬

	nnoremap <leader>1 I#<space><esc> \| A<space>#<esc> \| kyypv$r# \| yykP
augroup END

augroup rst_files
	nnoremap <leader>1 yypVr=
	nnoremap <leader>2 yypVr-
	nnoremap <leader>3 yypVr`
	nnoremap <leader>4 yypVr'
	nnoremap <leader>5 yypVr.
	nnoremap <leader>6 yypVr~
	nnoremap <leader>7 yypVr*
	nnoremap <leader>7 yypVr+
	nnoremap <leader>7 yypVr^
augroup END
