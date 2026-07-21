local nav_path = vim.fn.glob(
  vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-*/editor/nvim.lua"),
  false,
  true
)[1]

if nav_path and vim.uv.fs_stat(nav_path) then
  dofile(nav_path)
end
