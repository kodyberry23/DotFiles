return {
  'ojroques/nvim-bufdel',
  event = 'VeryLazy',
  opts = {
    next = 'cycle',
    quit = false,
  },
  keys = {
    -- Delete current buffer
    { '<leader>bc', '<Cmd>BufDel<CR>', desc = 'Delete buffer' },
    
    -- Delete all buffers
    { '<leader>ba', '<Cmd>BufDelAll<CR>', desc = 'Delete all buffers' },
    
    -- Delete all buffers except current
    { '<leader>bo', '<Cmd>BufDelOthers<CR>', desc = 'Delete other buffers' },
  },
}
