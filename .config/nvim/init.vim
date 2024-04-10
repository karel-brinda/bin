" let g:python2_host_prog = '/usr/bin/env python'
" let g:python3_host_prog = '/usr/bin/env python3'
let g:python3_host_prog = '~/miniconda/bin/python3'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc

