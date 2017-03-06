source ~/bin/vim-sensible/plugin/sensible.vim

source $VIMRUNTIME/mswin.vim
behave mswin

colo torte

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
augroup END

