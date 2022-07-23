require('bufferline').setup{
  options = {
    buffer_close_icon = '×',
    modified_icon = '●',
    close_icon = '⌫',
    left_trunc_marker = '←',
    right_trunc_marker = '→',
  }
}
vim.cmd[[
nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent>b] :BufferLineCycleNext<CR>
]]
