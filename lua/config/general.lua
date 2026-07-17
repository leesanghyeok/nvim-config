-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Keep cwd stable; change it manually when needed.
vim.opt.autochdir = false

--[[
  Command-line
--]]
-- Enhance command-line completion
vim.opt.wildmenu = true
-- Ignore when expanding wildcards
vim.opt.wildignore = "*.swp,*.swo,*.class"
