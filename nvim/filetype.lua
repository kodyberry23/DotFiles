-- Elixir filetype detection
vim.filetype.add({
  extension = {
    ex = "elixir",
    exs = "elixir",
    heex = "heex",
    leex = "heex",
    sface = "surface",
    eex = "eelixir",
  },
  filename = {
    ["mix.lock"] = "elixir",
  },
})
