" =============================================================================
" Quick reference (leader key: ,)
" =============================================================================
" Plugin maintenance
"   :PlugInstall       install declared plugins
"   :PlugUpdate        update installed plugins
"
" Everyday editing
"   Y               yank to end of line
"   ,<Space>        clear search highlight
"   ,r              save and reload config
"   ,l              toggle line numbers
"   Tab             jump to matching bracket
"   j / k           move by screen line
"   jk              Escape in Insert mode
"   ;               enter Command-line mode
"   ,W              remove trailing whitespace
"   ,q              reformat paragraph
"   ,w              split vertically and enter it
"   ,m              save and run make
"   ,M              save and run :terminal make (if supported)
"   ' / `           swap mark motions
"   Shift-h / Shift-l  previous / next tab
"   Ctrl-h / Ctrl-l   change panes
"   Ctrl-j / Ctrl-k   scroll half a page
"   ,t              toggle spaces or tabs
"   F5 or ,s        toggle spellcheck
"   Arrow keys are disabled in Normal, Visual, and Operator-pending modes.
"
" Filetype helpers
"   Markdown ,1 through ,4   insert heading levels
"   reStructuredText ,1 through ,9  insert heading underlines
"   reStructuredText ,c      insert a directive
"   Python ,1                add a # comment block
"   Vim ,1 or ,2             create a comment template
"   Insert-mode abbreviations include kg and lorem.
"
" Plugins that work automatically
"   NERDTree     opens at startup with no file; Ctrl-n toggles it
"   Airline      shows the statusline
"   YAML, Snakemake, HTML5, and Pandoc Markdown syntax load for matching files
"   vim-sleuth   detects indentation from the current buffer
"   vim-sensible applies sensible editor defaults
"   ALE          enables diagnostics/completion when the editor version supports it
"   Pencil       starts in Markdown files with soft wrapping and concealed markup
"
" On-demand plugin features (off until invoked)
"   ,u or :UndotreeToggle  show undo history
"   :CtrlP                 fuzzy-find files and buffers
"   :Ack {pattern}         search project text
"   Visual ,bi             wrap a selection with Blockit
"   ,g or :Goyo            toggle distraction-free writing; :Goyo! turns it off
"   :Pencil / :PencilOff   enable/disable prose mode in non-Markdown buffers
"   :VimtexCompile         start/stop LaTeX compilation (where VimTeX is supported)
"   :GenTocGFM             create a GitHub-style Markdown TOC
"   Markdown ,e            edit a code block or selected section in a temporary buffer
"   gcc / gc{motion}       comment a line / motion
"   ysiw", cs"', ds"      add, change, or delete surroundings
"   " or @ (Normal)        preview registers with vim-peekaboo
"   Ctrl-r (Insert)        preview registers with vim-peekaboo
"   Ctrl-{ / Ctrl-}        comment/uncomment via the optional repository-local helper
"
" =============================================================================
" Section: Core initialization
" =============================================================================
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
set undofile

" Do not parse conventional commit prefixes such as "vim:" as modelines.
augroup git_commit_messages
  autocmd!
  autocmd BufReadPost COMMIT_EDITMSG setlocal nomodeline
augroup END

" Optional repository-local commenting helpers.
let s:vimrc_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:vcomments = s:vimrc_dir . '/vcomments.vim'
if filereadable(s:vcomments)
  execute 'source ' . fnameescape(s:vcomments)
endif
unlet s:vimrc_dir s:vcomments
if exists('*Comment') && exists('*Uncomment')
  noremap <C-{> :call Comment()<CR>
  noremap <C-}> :call Uncomment()<CR>
endif









" =============================================================================
" Section: Optional plugins
" =============================================================================

let g:tex_flavor = 'latex'

if exists('*plug#begin') || globpath(&runtimepath, 'autoload/plug.vim') !=# ''
call plug#begin()


" Plugin: NERDTree — file tree; toggle with <C-n>.
Plug 'preservim/nerdtree'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && exists(':NERDTree') | NERDTree | endif

nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree
let NERDTreeShowHidden=1








" Plugin: vim-airline — status/tabline; automatic.
Plug 'vim-airline/vim-airline'
" Plugin: Blockit — wrap a visual selection in a text block with <leader>bi.
Plug 'sk1418/blockit'

" Plugin: vim-yaml — YAML syntax and indentation; automatic.
Plug 'avakhov/vim-yaml'

" Plugin: vim-snakemake — Snakemake syntax and indentation; automatic.
Plug 'karel-brinda/vim-snakemake'

" Plugin: ALE — async diagnostics/completion; use :ALEInfo or :ALEFix.
" Requires Vim 8.2+ or Neovim 0.10+.
let s:ale_supported = (has('nvim') && has('nvim-0.10')) || (!has('nvim') && v:version >= 802 && has('job') && has('channel') && has('timers'))
if s:ale_supported
  Plug 'dense-analysis/ale'
  let g:ale_enabled = 0
  let g:ale_completion_enabled = 1
  nmap <silent> <leader>a <Plug>(ale_toggle)
endif
unlet s:ale_supported

" Plugin: ctrlp.vim — fuzzy file, buffer, and MRU finder; start with :CtrlP.
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


" Plugin: ack.vim — project text search; use :Ack {pattern}.
Plug 'mileszs/ack.vim'


" Plugin: html5-syntax — extended HTML5 syntax highlighting; automatic.
Plug 'othree/html5-syntax.vim'


" Plugin: VimTeX — LaTeX editing/compilation; use :VimtexCompile or <localleader>ll.
" Requires Vim 9.2+ or Neovim 0.12.4+.
if (has('nvim') && has('nvim-0.12.4')) || (!has('nvim') && v:version >= 902)
  Plug 'lervag/vimtex'
endif


" Plugin: vim-pandoc-syntax — Pandoc Markdown with embedded LaTeX/YAML; automatic.
Plug 'vim-pandoc/vim-pandoc-syntax'


" Plugin: Undotree — visual undo history; toggle with <leader>u.
Plug 'mbbill/undotree'



" Plugin: vim-pencil — prose mode; automatic for Markdown, else :Pencil.
Plug 'reedes/vim-pencil'


" Plugin: Goyo — distraction-free writing; toggle with <leader>g or :Goyo.
Plug 'junegunn/goyo.vim'

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

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()


" Plugin: vim-peekaboo — register previews; press " or @, or <C-r> while inserting.
Plug 'junegunn/vim-peekaboo'


" Plugin: vim-markdown — GitHub-flavored Markdown; use <leader>e to edit a section.
Plug 'gabrielelana/vim-markdown'


" Plugin: vim-markdown-toc — Markdown TOC; generate one with :GenTocGFM.
Plug 'mzlogin/vim-markdown-toc'







" Plugin: vim-commentary — comment with gcc, or gc plus a motion/visual selection.
Plug 'tpope/vim-commentary'

" Plugin: vim-sleuth — detect indentation from buffer, modelines, and EditorConfig.
Plug 'tpope/vim-sleuth'

" Plugin: vim-surround — ysiw" adds quotes, cs"' changes, and ds" deletes them.
Plug 'tpope/vim-surround'


" Plugin: vim-sensible — sensible baseline editor defaults; automatic.
Plug 'tpope/vim-sensible'


call plug#end()
endif

" =============================================================================
" Section: Navigation and mappings
" =============================================================================

" Toggle undo history.
nnoremap <leader>u :UndotreeToggle<CR>

" Disabled commands: nnoremap / /\v; vnoremap / /\v

" search highlighting
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

nnoremap <leader>r :w<CR>:source $MYVIMRC<CR>

" Toggle line numbers.
nnoremap <leader>l :set number!<cr>

" Match bracket pairs with Tab.
nnoremap <tab> %
vnoremap <tab> %

" Move by screen line.
nnoremap j gj
nnoremap k gk

" Disable F1 help.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Use ; for :.
nnoremap ; :

" Use jk as Escape in Insert mode.
inoremap jk <esc>


" Remove trailing whitespace.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Reformat the current paragraph.
nnoremap <leader>q gqip

" Split vertically and enter the new window.
nnoremap <leader>w <C-w>v<C-w>l

nnoremap <leader>m :w<CR>:! make<CR>
if exists(':terminal')
  nnoremap <leader>M :w<CR>:terminal make<CR>
endif
" Disabled command: nnoremap <leader>M :w<CR>:! make \|\| 1<CR>
" Smart case-sensitive searching.
set ignorecase
set smartcase

" Swap ' and ` motions.
nnoremap ' `
nnoremap ` '

set title


" Change tabs.
nnoremap <S-l> gt
nnoremap <S-h> gT

" Change panes.
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Quick navigation.
nnoremap <C-j> <C-d>z.
nnoremap <C-k> <C-u>z.


" Disable arrow keys in Normal, Visual, and Operator-pending modes.

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" =============================================================================
" Section: Editor options
" =============================================================================
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


" =============================================================================
" Section: Indentation and whitespace
" =============================================================================
set list
if &encoding ==# 'utf-8'
  set listchars=tab:▸\ ,eol:¬
else
  set listchars=tab:>-,eol:$
endif

set expandtab
" Toggle between spaces and tabs for the current buffer.
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
nnoremap <silent> <leader>t mz:execute TabToggle()<CR>'z

" =============================================================================
" Section: Filetype-specific settings
" =============================================================================
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

" =============================================================================
" Section: Writing and Markdown
" =============================================================================
if globpath(&runtimepath, 'autoload/pencil.vim') !=# ''
  augroup pencil
    autocmd!
    autocmd filetype markdown,mkd call pencil#init()
  augroup END
endif

" Pencil defaults.
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 74
let g:pencil#joinspaces = 0
let g:pencil#cursorwrap = 1
let g:pencil#conceallevel = 3
let g:pencil#concealcursor = 'c'
let g:pencil#softDetectSample = 20
let g:pencil#softDetectThreshold = 130
" Toggle spellcheck with F5 or <leader>s.
nnoremap <silent> <F5> :set spell!<CR>
nnoremap <silent> <leader>s :set spell!<CR>
set spelllang=en_us

" Toggle Goyo.
nnoremap <silent> <leader>g :Goyo<CR>
