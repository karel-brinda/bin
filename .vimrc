"""""""
" LINKS
"""""""

set nocompatible
let mapleader = ','

syntax enable
filetype plugin indent on

nnoremap Y y$

if globpath(&runtimepath, 'colors/badwolf.vim') !=# ''
  colorscheme badwolf
endif
set modeline
set number

" CTRL-A comment, CTRL-B uncomment
let s:vimrc_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:vcomments = s:vimrc_dir . '/vcomments.vim'
if filereadable(s:vcomments)
  execute 'source ' . fnameescape(s:vcomments)
endif
unlet s:vimrc_dir s:vcomments
map <C-{> :call Comment()<CR>
map <C-}> :call Uncomment()<CR>









"""""""""""""""""
" PLUGINS - BEGIN
"""""""""""""""""

let g:tex_flavor = 'latex'

if exists('*plug#begin') || globpath(&runtimepath, 'autoload/plug.vim') !=# ''
call plug#begin()


""""""""""""""""""""""""""""
" Nerdtree - a tree explorer
""""""""""""""""""""""""""""
" File tree; toggle with <C-n>.
Plug 'preservim/nerdtree'
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree
let NERDTreeShowHidden=1
"let NERDTreeMapOpenInTab='<CR>'








"if !has('nvim') """"""""""""""""""""""""""""""
"	" Syntastic - a syntax checker
"	""""""""""""""""""""""""""""""
"	" - either flake8, pyflakes or pylint have to be installed
"	Plug 'scrooloose/syntastic'
"	let g:syntastic_check_on_open = 1
"else
"	Plug 'neomake/neomake'
"endif


""""""""""""""""""""""""""
" PowerLine - a status bar
""""""""""""""""""""""""""
" unfortunately, doesn't work with neovim
" Status/tabline; configured automatically.
Plug 'vim-airline/vim-airline'
"if !has('nvim')
	"Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"else
"	Plug 'bling/vim-airline'
	"let g:airline_extensions = []
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""
" Blockit - a vim plugin to wrap lines in a block
"""""""""""""""""""""""""""""""""""""""""""""""""
" - visual block mode - <leader>bi
" Wrap a visual selection in a text block with <leader>bi.
Plug 'sk1418/blockit'

""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe - a code completition engine
""""""""""""""""""""""""""""""""""""""""""""
" Installation
"   cd ~/.vim/bundle/YouCompleteMe
"   ./install.py --clang-completer --system-libclang #--system-boost
if v:version > 740
	"Plug 'Valloric/YouCompleteMe'
endif

""""""""""""""""""
" Vim-ansible-yaml
""""""""""""""""""
" YAML syntax and indentation; automatic.
Plug 'avakhov/vim-yaml'

"""""""""""""""
" Vim-Snakemake
"""""""""""""""
" Snakemake syntax and indentation; automatic.
Plug 'karel-brinda/vim-snakemake'

"""""
" ALE
"""""
" ALE requires Vim 8.2+ or Neovim 0.10+.
let s:ale_supported = (has('nvim') && has('nvim-0.10')) || (!has('nvim') && v:version >= 802 && has('job') && has('channel') && has('timers'))
if s:ale_supported
  " Async diagnostics/completion; use :ALEInfo or :ALEFix.
  Plug 'dense-analysis/ale'
  let g:ale_completion_enabled = 1
endif
unlet s:ale_supported

"""""""""""
" ctrlp.vim
"""""""""""
" Fuzzy file, buffer, and MRU finder; start with :CtrlP.
Plug 'ctrlpvim/ctrlp.vim'

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
unlet! g:ctrlp_user_command
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --glob "!.git/*"'
elseif executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }


""""""""""
" acck.vim
""""""""""
" Project text search; use :Ack {pattern}.
Plug 'mileszs/ack.vim'


""""""""""
" html5-syntax
""""""""""
" Extended HTML5 syntax highlighting; automatic.
Plug 'othree/html5-syntax.vim'


""""""""
" vimtex
""""""""
" Current VimTeX requires Vim 9.2+ or Neovim 0.12.4+.
if (has('nvim') && has('nvim-0.12.4')) || (!has('nvim') && v:version >= 902)
  " LaTeX editing and compilation; use :VimtexCompile or <localleader>ll.
  Plug 'lervag/vimtex'
endif


"""""""""""""""""""
" vim-pandoc-syntax
"""""""""""""""""""
" Pandoc Markdown (markdown.pandoc), including embedded LaTeX and YAML; automatic.
Plug 'vim-pandoc/vim-pandoc-syntax'


"""""""""""""""
" vim-rmarkdown
"""""""""""""""
"Plug 'vim-pandoc/vim-rmarkdown'


"""""""""""""
" Python-mode
"""""""""""""
"Plug 'python-mode/python-mode'
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
" undotree
"""""""""""
" Visual undo history; toggle with <leader>u.
Plug 'mbbill/undotree'



""""""""""""
" vim-pencil
""""""""""""
" activate by :Pencil
" Prose mode: soft wrapping and concealed Markdown markup; automatic for Markdown, else :Pencil.
Plug 'reedes/vim-pencil'


""""""
" goyo
""""""
" activate by :goyo
" Distraction-free writing; toggle with <leader>g or :Goyo.
Plug 'junegunn/goyo.vim' " Full screen writing mode

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
" Register previews; press " or @ in Normal mode, or <C-r> while inserting.
Plug 'junegunn/vim-peekaboo'


""""""""""""""
" vim-markdown
""""""""""""""
" GitHub-flavored Markdown syntax; use <leader>e to edit a selected/fenced section.
Plug 'gabrielelana/vim-markdown'


""""""""""""""""""
" vim-markdown-toc
""""""""""""""""""
" generating github toc:
" :GenTocGFM
" Markdown: generate a GitHub-style table of contents with :GenTocGFM.
Plug 'mzlogin/vim-markdown-toc'







""""""""""""""""
" TPOPE PLUGINGS
""""""""""""""""

"" VIM-COMMENTARY
"" git functionality for vim
" comment stuff out
" - gcc to comment out a line
" - gc to comment out the target of a motion (for example, gcap to comment out a paragraph)
" - adding a custom type: autocmd FileType apache setlocal commentstring=#\ %s
" Comment/uncomment with gcc (line) or gc plus a motion/visual selection.
Plug 'tpope/vim-commentary'

"" VIM-FUGITIVE
"" git functionality for vim
"Plug 'tpope/vim-fugitive'

"" VIM-SLEUTH
"" automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
" Detect indentation from the buffer, modelines, and EditorConfig; automatic.
Plug 'tpope/vim-sleuth'

"" VIM-SURROUND
"" plugin provides mappings to easily delete, change and add surroundings in pairs
"" - cs"'
"" - cs'<q>
"" - cst"
"" - ds"
" Surround text: ysiw" adds quotes, cs"' changes quotes, and ds" deletes quotes.
Plug 'tpope/vim-surround'


"" VIM-SENSIBLE
"" a universal set of defaults
" Sensible baseline editor defaults; automatic.
Plug 'tpope/vim-sensible'


" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
endif
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'





"""""""""""""""
" PLUGINS - END
"""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set relativenumber
set undofile

" toggle undotree
nnoremap <leader>u :UndotreeToggle<CR>

" fix regex
" nnoremap / /\v
" #vnoremap / /\v

" search highlighting
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

nnoremap <leader>r :w<CR>:source $MYVIMRC<CR>

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

nnoremap <leader>m :w<CR>:! make<CR>
if exists(':terminal')
  nnoremap <leader>M :w<CR>:terminal make<CR>
endif
"nnoremap <leader>M :w<CR>:! make \|\| 1<CR>
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
iab loremm Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab loremmm Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor


set list
if &encoding ==# 'utf-8'
  set listchars=tab:▸\ ,eol:¬
else
  set listchars=tab:>-,eol:$
endif

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
	autocmd BufWritePre * %s/\s\+$//e
	autocmd FileType python setlocal expandtab textwidth=110 tabstop=4 softtabstop=4 shiftwidth=4 autoindent

	autocmd FileType python nnoremap <leader>1 I#<space><esc> \| A<space>#<esc> \| kyypv$r# \| yykP
augroup END

augroup sh_files
	autocmd!
	autocmd FileType sh setlocal noexpandtab
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
