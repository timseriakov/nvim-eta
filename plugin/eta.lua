-- Auto-load plugin for Eta template support
-- This file is automatically loaded by Neovim

-- Only load once
if vim.g.loaded_nvim_eta then
  return
end
vim.g.loaded_nvim_eta = 1

-- Initialize plugin with default settings
require("nvim-eta").setup()

