" specify directory for plugins
call plug#begin('~/.config/nvim/plugged')

" Nord theme
Plug 'arcticicestudio/nord-vim'

" scratch buffer
Plug 'mtth/scratch.vim'

" all the git things
" gitgutter indicates added, deleted, and modified lines
Plug 'airblade/vim-gitgutter'
" fugitive provides 'git blame'
" https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
" rhubarb....
Plug 'tpope/vim-rhubarb'
" commentary provides shortcuts for commenting out blocks of code
Plug 'tpope/vim-commentary'

" Plenary is a dependency for Telescope
Plug 'nvim-lua/plenary.nvim'
" Telescope is a fuzzy finder and file browser
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter'
" telescope-fzf-native for improved sort performance
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" typescript code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" seamless vim/tmux pane navigation
Plug 'christoomey/vim-tmux-navigator'
" initialize plugin system
call plug#end()

set ruler                   " show cursor position in status bar
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=100                  " set a 100 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
set tabstop=4               " number of columns occupied by a tab character
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set clipboard=unnamedplus   " yank to system clipboard
set hidden                  " i guess needed for scratch buffer to hide when inactive
set list                    " show tabs as >
set listchars=tab:>-

syntax on
colorscheme nord

let mapleader = ","

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Easily clear search highlight
nnoremap <esc> :noh <cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" redraw screen
nnoremap <leader>r <C-L>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader>t :!bin/rspec %:p<cr>
nnoremap <leader>x :!ruby %:p<cr>

" netrw config
let g:netrw_keepdir = 0
let g:netrw_winsize = 15
let g:netrw_banner = 0

" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" Update sign column every quarter second (for gitgutter)
set updatetime=250

" Show commits for every source line
nnoremap <Leader>gb :Git blame<CR>

" Prettify json
nnoremap <Leader>jq :%!jq<CR>

" quick show current directory/project directory
nnoremap <leader>dd :Lexplore %:p:h<CR>
nnoremap <leader>da :Lexplore <CR>
" easier nav in file explorer
function! NetrwMapping()
    nmap <buffer> <esc> :Lexplore <CR>
    nmap <buffer> <C-J> <C-W><C-J>
    nmap <buffer> <C-K> <C-W><C-K>
    nmap <buffer> <C-L> <C-W><C-L>
    nmap <buffer> <C-H> <C-W><C-H>
endfunction

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

autocmd BufWritePre * :%s/\s\+$//e

" code completion server for typescript
let g:coc_global_extensions = ['coc-tsserver']

" You have to remap <cr> to make it confirm completion.
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" To make <cr> select the first completion item and confirm the completion when no item has been selected:
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" scratch configuration
let g:scratch_horizontal=0
let g:scratch_height=80
let g:scratch_persistence_file = '.scratch.vim'
nnoremap <leader>s :Scratch <CR>
