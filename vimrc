" Highlight current line
set cursorline

" Automatic word wrapping at 80 characters
" http://vim.wikia.com/wiki/Automatic_word_wrapping
set tw=79

" Center vertically
" http://vim.wikia.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
set scrolloff=999

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-sensible'
Plug 'dpelle/vim-LanguageTool'

" Initialize plugin system
call plug#end()

" Unified color scheme (default: dark)
colo seoul256

" Execute local vimrc files (https://vimtricks.com/p/local-vimrc-files/)
set exrc

" Specify LanguageTool command
let g:languagetool_cmd='java -jar ~/bin/LanguageTool-5.8/languagetool-commandline.jar'

" Set maxmempattern to maximum allowed (2GB memory)
" More info https://vim-jp.org/vimdoc-en/options.html#'maxmempattern' and in my
" private wiki
set mmp=2000000

