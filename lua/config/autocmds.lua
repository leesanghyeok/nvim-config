-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = vim.api.nvim_create_augroup("StarkAutoChecktime", { clear = true }),
  callback = function(event)
    if vim.bo[event.buf].buftype ~= "" then
      return
    end

    vim.cmd("checktime " .. event.buf)
  end,
})

-- Show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

local text_filetypes = {
  gitcommit = true,
  markdown = true,
  plaintex = true,
  text = true,
  typst = true,
}

local function disable_text_spell(buf)
  if text_filetypes[vim.bo[buf].filetype] then
    -- LazyVim은 문서 파일에서 영어 spellcheck를 자동으로 켠다.
    -- 한글을 많이 쓰면 모든 한글 단어가 오타처럼 밑줄 표시되므로 spell만 끈다.
    vim.opt_local.spell = false
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("StarkDisableTextSpell", { clear = true }),
  pattern = vim.tbl_keys(text_filetypes),
  callback = function(event)
    disable_text_spell(event.buf)
  end,
})

disable_text_spell(0)
