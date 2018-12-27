" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-sensible'

" Initialize plugin system
call plug#end()

" Unified color scheme (default: dark)
colo seoul256

" Automatic word wrapping at 80 characters
" http://vim.wikia.com/wiki/Automatic_word_wrapping
set tw=79
set cursorline

" Center vertically
" http://vim.wikia.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
set scrolloff=999

