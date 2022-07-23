""" Kodys Neovim Init.vim

""" Vim-Plug
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

 Plug 'patstockwell/vim-monokai-tasty'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
 Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'nvim-lualine/lualine.nvim'
 Plug 'preservim/nerdtree'
 Plug 'simrat39/rust-tools.nvim'
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'kyazdani42/nvim-tree.lua'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'roxma/vim-hug-neovim-rpc'
 Plug 'roxma/nvim-yarp', { 'do': 'pip install -r requirements.txt' }

function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }


call plug#end()

colorscheme vim-monokai-tasty

lua << EOF
require('settings')
require('keymappings')
require('telescope-config')
require('toggleterm-config')
require('treesitter-config')
require('rust-tools-config')
require('nvim-tree-config')
EOF

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Default keys
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })
