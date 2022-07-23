local o = vim.o
local wo = vim.wo
local bo = vim.opt
local opt = vim.opt
local cmd = vim.cmd
-- ========== General Settings ==========
cmd('filetype plugin indent on')
-- Options
opt.termguicolors = true
opt.wrap = false
-- Global
o.background = 'dark'
o.shortmess = o.shortmess .. 'c'
o.backspace = 'indent,eol,start'
o.whichwrap = 'b,s,<,>,[,],h,l'
o.fileencoding = 'utf-8'
o.splitbelow = true
o.splitright = true
o.showtabline = 2
o.clipboard = 'unnamedplus'
o.hlsearch = false
o.ignorecase = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.autoindent = true
o.expandtab = true
o.history = 1000
o.showcmd = true
o.showmode = true
o.gcr = 'a:blinkon0'
o.visualbell = true
o.autoread = true
o.hidden = true
o.backup = false
o.writebackup = false
o.updatetime = 300
o.timeoutlen = 100
o.mouse = 'a'
-- Window
wo.number = true
wo.relativenumber = true
-- Buffer
bo.tabstop = 2
bo.shiftwidth = 2
bo.autoindent = true
bo.expandtab = true
bo.syntax = 'on'
bo.swapfile = false
-- ========== Scrolling ==========
-- Global
o.scrolloff = 8
o.sidescrolloff = 15
o.sidescroll = 1
