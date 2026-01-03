return {
  'ojroques/nvim-bufdel',
  event = 'VeryLazy',
  opts = {
    next = 'cycle',
    quit = false,
  },
  keys = {
    -- Delete current buffer
    { '<leader>bcc', '<Cmd>BufDel<CR>', desc = 'Close current buffer' },
    
    -- Delete all buffers
    { '<leader>bca', '<Cmd>BufDelAll<CR>', desc = 'Close all buffers' },
    
    -- Delete all buffers except current
    { '<leader>bco', '<Cmd>BufDelOthers<CR>', desc = 'Close other buffers' },
  },
}
