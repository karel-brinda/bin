source ~/bin/vim-sensible/plugin/sensible.vim

source $VIMRUNTIME/mswin.vim
behave mswin

colo torte

au BufNewFile,BufRead Snakefile set syntax=python
filetype plugin indent on
syntax on
set number

" allow aliases
:set shellcmdflag=-ic

map <f9> :w<CR>:! make<CR>


