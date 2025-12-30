local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Floating window borders (Neovim 0.11+)
vim.o.winborder = "rounded"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Swapfiles (disable)
opt.swapfile = false

-- Backspace
opt.backspace = "indent,eol,start"

-- Scrolling
opt.scrolloff = 10 -- Keep 10 lines above/below cursor

-- Update time (faster completion)
opt.updatetime = 50

-- Auto-reload files changed outside of vim
opt.autoread = true

-- Timeout for mapped sequences (default 1000ms is too slow)
opt.timeoutlen = 300 -- Wait 300ms for next key in a mapped sequence
opt.ttimeoutlen = 10 -- Wait 10ms for key codes (faster Esc)

-- Encoding
opt.iskeyword:append("-")

opt.guicursor = "n-v-c-sm:block,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20"