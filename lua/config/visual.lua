-- Enable if the terminal support true colors
if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end

local options = {
  opt = {
    number = true, -- Line numbers on
    relativenumber = false, -- Keep absolute line numbers instead of relative numbers
    signcolumn = "yes", -- Always show signcolumns

    breakindent = true, -- Every wrapped line will continue visually indented, thus preserving horizontal blocks of text.
    linebreak = false, -- Vim will wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen.
    showbreak = "» ", -- String to put at the start of lines that have been wrapped.
    wrap = true, -- Change how text is displayed. When on, lines longer than the width of the window will wrap and displaying continues on the next line.

    showtabline = 2, -- Only if there are at least two tab pages

    ruler = true, -- Show ruler
    showcmd = true, -- Show the command typing
    showmode = false, -- Hide the current mode

    cursorline = true, -- Highlight current line
    showmatch = true, -- Show matching brackets
    matchtime = 5, -- Bracket blinking

    colorcolumn = "80", -- Mark the 80th column (ported from the legacy vimrc; the highlight color comes from the colorscheme)
  },
  g = {},
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
