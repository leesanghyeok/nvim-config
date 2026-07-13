return {
  -- Diagnostics display: long messages (e.g. terraform validate errors) are
  -- unreadable as end-of-line virtual text. Disable virtual_text and instead
  -- show the full message as virtual lines below the cursor line only.
  -- LazyVim passes opts.diagnostics to vim.diagnostic.config(), so this
  -- applies to nvim-lint diagnostics as well as LSP ones.
  -- <leader>cd (float) and trouble (<leader>xx) remain available.
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        virtual_lines = { current_line = true },
      },
    },
  },
}
