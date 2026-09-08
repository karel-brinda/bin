let s:python3_host = expand('~/miniconda/bin/python3')
if executable(s:python3_host)
  let g:python3_host_prog = s:python3_host
endif
unlet s:python3_host

set runtimepath^=~/.vim runtimepath+=~/.vim/after

source ~/.vimrc
