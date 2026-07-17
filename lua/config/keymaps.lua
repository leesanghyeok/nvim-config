-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

-- <Esc> is too annoying to type
keymap("i", "jkj", "<ESC>")


--[[
  Windows
--]]
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to Left Window" })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to Lower Window" })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to Upper Window" })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to Right Window" })
keymap("n", "<C-ㅗ>", "<C-w>h", { desc = "Go to Left Window" })
keymap("n", "<C-ㅓ>", "<C-w>j", { desc = "Go to Lower Window" })
keymap("n", "<C-ㅏ>", "<C-w>k", { desc = "Go to Upper Window" })
keymap("n", "<C-ㅣ>", "<C-w>l", { desc = "Go to Right Window" })
keymap("t", "<C-ㅗ>", "<C-\\><C-n><C-w>h", { desc = "Go to Left Window" })
keymap("t", "<C-ㅓ>", "<C-\\><C-n><C-w>j", { desc = "Go to Lower Window" })
keymap("t", "<C-ㅏ>", "<C-\\><C-n><C-w>k", { desc = "Go to Upper Window" })
keymap("t", "<C-ㅣ>", "<C-\\><C-n><C-w>l", { desc = "Go to Right Window" })


--[[
  Tabs
--]]
keymap("n", "<Tab><Tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap("n", "<Tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })
keymap("n", "<Tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
keymap("n", "<Tab>s", "<cmd>tabs<cr>", { desc = "List Tabs" })
keymap("n", "<Tab>^", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap("n", "<Tab>$", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap("n", "<Tab>k", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap("n", "<Tab>j", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap("n", "<Tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<Tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
keymap("n", "<Tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<Tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
keymap("n", "<Tab><Right>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<Tab><Left>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
for i = 1, 9 do
  keymap("n", "<Tab>" .. i, "<cmd>tabnext " .. i .. "<cr>", { desc = "Go to Tab " .. i })
end
