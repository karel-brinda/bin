"""""""
" LINKS
"""""""
" - http://nvie.com/posts/how-i-boosted-my-vim/
"

source $HOME/bin/.vim/vim-sensible/plugin/sensible.vim

" source $VIMRUNTIME/mswin.vim
"if has("clipboard")
"	" CTRL-X is Cut
"	vnoremap <C-X> "+x
"
"	" CTRL-C is Copy
"	vnoremap <C-C> "+y
"
"	" CTRL-V is Paste
"	map <C-V> "+gP
"	cmap <C-V>	<C-R>+
"endif

nnoremap Y y$

"if !exists('g:colors_name') || g:colors_name != 'badwolf'
colorscheme badwolf
"endif

set guifont=Hack:h11

syntax on
filetype indent plugin on
set modeline
set number

" allow aliases
:set shellcmdflag=-ic

" CTRL-A comment, CTRL-B uncomment
source ~/bin/vcomments.vim
map <C-{> :call Comment()<CR>
map <C-}> :call Uncomment()<CR>


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
let NERDTreeShowHidden=1
"let NERDTreeMapOpenInTab='<CR>'


"""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree-tabs - NERDTree and tabs together in Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup=2

""""""""""""""
" Vim-fugitive
""""""""""""""
Plugin 'tpope/vim-fugitive'


if !has('nvim')
	""""""""""""""""""""""""""""""
	" Syntastic - a syntax checker
	""""""""""""""""""""""""""""""
	" - either flake8, pyflakes or pylint have to be installed
	Plugin 'scrooloose/syntastic'
	let g:syntastic_check_on_open = 1
else
	Plugin 'neomake/neomake'
endif

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
	"Plugin 'Valloric/YouCompleteMe'
endif

""""""""""""""""""
" Vim-ansible-yaml
""""""""""""""""""
Plugin 'avakhov/vim-yaml'

""""""""""""""""""
" Vim-colorschemes
""""""""""""""""""
"Plugin 'flazz/vim-colorschemes'
Plugin 'sjl/badwolf'

"""""""""""""""
" Vim-Snakemake
"""""""""""""""
Plugin 'karel-brinda/vim-snakemake'

"""""
" ALE
"""""
Plugin 'w0rp/ale'

"""""""""""
" ctrlp.vim
"""""""""""
Plugin 'kien/ctrlp.vim'

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }


""""""""""
" acck.vim
""""""""""
Plugin 'mileszs/ack.vim'


""""""""""
" html5-syntax
""""""""""
Plugin 'othree/html5-syntax.vim'


""""""""
" vimtex
""""""""
Plugin 'lervag/vimtex'
let g:tex_flavor = 'latex'


"""""""""""""""""""
" vim-pandoc-syntax
"""""""""""""""""""
Plugin 'vim-pandoc/vim-pandoc-syntax'


"""""""""""""""
" vim-rmarkdown
"""""""""""""""
"Plugin 'vim-pandoc/vim-rmarkdown'


"""""""""""""
" Python-mode
"""""""""""""
"Plugin 'python-mode/python-mode'
let g:pymode_python = 'python3'
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"
"
" Override run current python file key shortcut to Ctrl-Shift-e
let g:pymode_run_bind = "<C-S-e>"
"
" Override view python doc key shortcut to Ctrl-Shift-d
let g:pymode_doc_bind = "<C-S-d>"

let g:pymode_options_colorcolumn = 0


"""""""""""
" gundo.vim
"""""""""""
Plugin 'sjl/gundo.vim'
if has('python3')
    let g:gundo_prefer_python3 = 1
endif


"""""""""""""""
" NerdCommenter
"""""""""""""""
" - [count]<leader>cc - comment
" - [count]<leader>cu - uncomment

Plugin 'scrooloose/nerdcommenter'


""""""""""""
" vim-pencil
""""""""""""
" activate by :Pencil
Plugin 'reedes/vim-pencil'


""""""
" goyo
""""""
" activate by :goyo
Plugin 'junegunn/goyo.vim' " Full screen writing mode

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

function! s:auto_goyo()
	if &ft == 'markdown'
		Goyo
	else
		"let bufnr = bufnr('%')
		"Goyo!
		"execute 'b '.bufnr
	endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()


""""""""""""""
" vim-peekaboo
""""""""""""""
" you can see the contents of the registers
Plugin 'junegunn/vim-peekaboo'


""""""""""""""
" vim-markdown
""""""""""""""
Plugin 'gabrielelana/vim-markdown'


""""""""""""""""""
" vim-markdown-toc
""""""""""""""""""
" generating github toc:
" :GenTocGFM
Plugin 'mzlogin/vim-markdown-toc'


""""
"if has('nvim')
"	Plugin 'roxma/nvim-completion-manager'
"endif

call vundle#end()            " required
filetype plugin indent on    " required



""""""""""""""
" vim-sensible
""""""""""""""
Plugin 'tpope/vim-sensible'


"""""""""""""""
" PLUGINS - END
"""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set relativenumber
set undofile
let mapleader = ","

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" fix regex
" nnoremap / /\v
" #vnoremap / /\v

" search highlighting
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

nnoremap <leader>r :w<cr> \| :so ~/.vimrc \| :PluginInstall<cr>

" line numbers on/off
nnoremap <leader>l :set number!<cr>

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

" jk is escape
inoremap jk <esc>


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
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k

" Quick navigation
noremap <C-j> <C-d>z.
noremap <C-k> <C-u>z.


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

set mouse=r

iab kg karel.brinda@gmail.com

iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor


set list
set listchars=tab:▸\ ,eol:¬

filetype plugin indent on


set expandtab
" allow toggling between local and default mode
function TabToggle()
	if &expandtab
		set shiftwidth=8
		set softtabstop=0
		set noexpandtab
	else
		set shiftwidth=4
		set softtabstop=4
		set expandtab
	endif
endfunction
nmap <silent> <leader>t mz:execute TabToggle()<CR>'z

augroup python_files
	autocmd!
	"autocmd FileType python setlocal noexpandtab
	"autocmd FileType python set tabstop=4
	"autocmd FileType python set shiftwidth=4
	au BufRead,BufNewFile *.py set expandtab
	autocmd BufWritePre * %s/\s\+$//e

	set expandtab           " enter spaces when tab is pressed
	set textwidth=110       " break lines when line length increases
	set tabstop=4           " use 4 spaces to represent tab
	set softtabstop=4
	set shiftwidth=4        " number of spaces to use for auto indent
	set autoindent          " copy indent from current line when starting a new line

	autocmd FileType python nnoremap <leader>1 I#<space><esc> \| A<space>#<esc> \| kyypv$r# \| yykP
augroup END

augroup sh_files
	set noexpandtab
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

augroup pencil
	autocmd!
	autocmd filetype markdown,mkd call pencil#init()
augroup END

augroup goyo_markdown
	autocmd!
	autocmd BufNewFile,BufRead * call s:auto_goyo()
augroup END


" Pencil / Writing Controls {{{
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 74
let g:pencil#joinspaces = 0
let g:pencil#cursorwrap = 1
let g:pencil#conceallevel = 3
let g:pencil#concealcursor = 'c'
let g:pencil#softDetectSample = 20
let g:pencil#softDetectThreshold = 130
" }}}

" Spellcheck
nmap <silent> <F5> :set spell!<CR>
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us

" Goyo
nmap <silent> <leader>g :Goyo<CR>


" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL


let g:ale_completion_enabled = 1

