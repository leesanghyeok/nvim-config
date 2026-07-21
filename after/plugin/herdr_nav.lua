local nav_path = vim.fn.glob(
  vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-*/editor/nvim.lua"),
  false,
  true
)[1]

if nav_path and vim.uv.fs_stat(nav_path) then
  dofile(nav_path)
end

local function navigate(wincmd, dir)
  local prev = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)
  if vim.api.nvim_get_current_win() ~= prev then
    return
  end

  if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
    local herdr = vim.env.HERDR_BIN_PATH
    if herdr == nil or herdr == "" then
      herdr = "herdr"
    end
    vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--current" })
  elseif vim.env.TMUX and vim.env.TMUX ~= "" then
    local tmux = { left = "Left", down = "Down", up = "Up", right = "Right" }
    pcall(vim.cmd, "TmuxNavigate" .. tmux[dir])
  end
end

_G.herdr_navigate = navigate

local function set_map(lhs, wincmd, dir, desc)
  vim.keymap.set("n", lhs, function()
    navigate(wincmd, dir)
  end, { silent = true, noremap = true, desc = desc })

  vim.keymap.set("t", lhs, ("<C-\\><C-n><cmd>lua _G.herdr_navigate(%q, %q)<cr>"):format(wincmd, dir), {
    silent = true,
    noremap = true,
    desc = desc,
  })
end

local function setup_maps()
  set_map("<C-h>", "h", "left", "Navigate left (vim/herdr)")
  set_map("<C-j>", "j", "down", "Navigate down (vim/herdr)")
  set_map("<C-k>", "k", "up", "Navigate up (vim/herdr)")
  set_map("<C-l>", "l", "right", "Navigate right (vim/herdr)")
  set_map("<C-ㅗ>", "h", "left", "Navigate left (vim/herdr)")
  set_map("<C-ㅓ>", "j", "down", "Navigate down (vim/herdr)")
  set_map("<C-ㅏ>", "k", "up", "Navigate up (vim/herdr)")
  set_map("<C-ㅣ>", "l", "right", "Navigate right (vim/herdr)")
end

setup_maps()

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.schedule(setup_maps)
  end,
})
