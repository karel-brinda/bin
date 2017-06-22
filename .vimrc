"""""""
" LINKS
"""""""
" - http://nvie.com/posts/how-i-boosted-my-vim/
"

source $HOME/bin/.vim/vim-sensible/plugin/sensible.vim

" source $VIMRUNTIME/mswin.vim
if has("clipboard")
    " CTRL-X is Cut
    vnoremap <C-X> "+x

    " CTRL-C is Copy
    vnoremap <C-C> "+y

    " CTRL-V is Paste
    map <C-V> "+gP
    cmap <C-V>	<C-R>+
endif


colorscheme badwolf

set guifont=Hack:h11

syntax on
filetype indent plugin on
set modeline
set number

" allow aliases
:set shellcmdflag=-ic

"map <f9> :w<CR>:! make!<CR>

set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""
" PLUGINS - BEGIN
"""""""""""""""""

set rtp+=$HOME/bin/.vim/bundle/Vundle.vim
call vundle#begin()

""""""""
" Vundle
""""""""
" - :PluginInstall
" - :PluginUpdate
Plugin 'VundleVim/Vundle.vim'

""""""""""""""""""""""""""""
" Nerdtree - a tree explorer
""""""""""""""""""""""""""""
Plugin 'scrooloose/nerdtree'
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree


"""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree-tabs - NERDTree and tabs together in Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup=2

""""""""""""""
" Vim-fugitive
""""""""""""""
Plugin 'tpope/vim-fugitive'


""""""""""""""""""""""""""""""
" Syntastic - a syntax checker
""""""""""""""""""""""""""""""
" - either flake8, pyflakes or pylint have to be installed
Plugin 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-surround - transformation of ", ', (, [, ...
""""""""""""""""""""""""""""""""""""""""""""""""""
" - cs"'
" - cs'<q>
" - cst"
" - ds"
Plugin 'tpope/vim-surround'

""""""""""""""""""""""""""
" PowerLine - a status bar
""""""""""""""""""""""""""
" unfortunately, doesn't work with neovim
if !has('nvim')
	Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
else
	Plugin 'bling/vim-airline'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""
" Blockit - a vim plugin to wrap lines in a block
"""""""""""""""""""""""""""""""""""""""""""""""""
" - visual block mode - <leader>bi
Plugin 'sk1418/blockit'

""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe - a code completition engine
""""""""""""""""""""""""""""""""""""""""""""
" Installation
"   cd ~/.vim/bundle/YouCompleteMe
"   ./install.py --clang-completer --system-libclang #--system-boost
if v:version > 740
	Plugin 'Valloric/YouCompleteMe'
endif

""""""""""""""""""
" Vim-ansible-yaml
""""""""""""""""""
Plugin 'avakhov/vim-yaml'

""""""""""""""""""
" Vim-colorschemes
""""""""""""""""""
Plugin 'flazz/vim-colorschemes'

"""""""""""""""
" Vim-Snakemake
"""""""""""""""
Plugin 'ibab/vim-snakemake'

"""""""""""""
" Python-mode
"""""""""""""
"Plugin 'python-mode/python-mode'
"let g:pymode_python = 'python3'
"" Override go-to.definition key shortcut to Ctrl-]
"let g:pymode_rope_goto_definition_bind = "<C-]>"
"
"" Override run current python file key shortcut to Ctrl-Shift-e
"let g:pymode_run_bind = "<C-S-e>"
"
"" Override view python doc key shortcut to Ctrl-Shift-d
"let g:pymode_doc_bind = "<C-S-d>"


"""""""""""""""
" NerdCommenter
"""""""""""""""
" - [count]<leader>cc - comment
" - [count]<leader>cu - uncomment

Plugin 'scrooloose/nerdcommenter'


""""

call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""
" PLUGINS - END
"""""""""""""""



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

nnoremap <leader>r :w<cr> \| :so ~/.vimrc \| :PluginInstall<cr>

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

set shellcmdflag=-ic

nnoremap <leader>m :w<CR>:! make<CR>
nnoremap <leader>M :w<CR>:! make \|\| 1<CR>
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


" Stop using arrows

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

set hidden
set history=1000
set wildmenu
set wildmode=list:longest
set scrolloff=3


iab kg karel.brinda@gmail.com
iab kh kbrinda@hsph.harvard.edu

iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor


set list
set listchars=tab:▸\ ,eol:¬

filetype plugin indent on

augroup python_files
	autocmd!
	autocmd FileType python setlocal noexpandtab
	autocmd FileType python set tabstop=4
	autocmd FileType python set shiftwidth=4
	autocmd BufWritePre * %s/\s\+$//e

	autocmd FileType python nnoremap <leader>1 I#<space><esc> \| A<space>#<esc> \| kyypv$r# \| yykP
augroup END

augroup markdown_files
	autocmd!
	autocmd FileType markdown nnoremap <leader>1 0i#<space><esc>
	autocmd FileType markdown nnoremap <leader>2 0i##<space><esc>
	autocmd FileType markdown nnoremap <leader>3 0i###<space><esc>
	autocmd FileType markdown nnoremap <leader>4 0i####<space><esc>
augroup END

augroup rst_files
	autocmd!
	autocmd FileType rst nnoremap <leader>1 yypVr=
	autocmd FileType rst nnoremap <leader>2 yypVr-
	autocmd FileType rst nnoremap <leader>3 yypVr`
	autocmd FileType rst nnoremap <leader>4 yypVr'
	autocmd FileType rst nnoremap <leader>5 yypVr.
	autocmd FileType rst nnoremap <leader>6 yypVr~
	autocmd FileType rst nnoremap <leader>7 yypVr*
	autocmd FileType rst nnoremap <leader>8 yypVr+
	autocmd FileType rst nnoremap <leader>9 yypVr^

	autocmd FileType rst nnoremap <leader>c 0i::<space><esc>
augroup END

augroup vim_files
	autocmd!
	autocmd FileType vim nnoremap <leader>1 I"<space><esc> \| VgU \| yyPv$r" \| yyjp
	autocmd FileType vim nnoremap <leader>2 I"<space><esc> \| yyPv$r" \| yyjp
augroup END

" Spellcheck
nmap <silent> <F5> :set spell!<CR>
set spelllang=en_us


