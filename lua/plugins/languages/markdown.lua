local function ensure_installed(opts, names)
  opts.ensure_installed = opts.ensure_installed or {}
  for _, name in ipairs(names) do
    if not vim.tbl_contains(opts.ensure_installed, name) then
      table.insert(opts.ensure_installed, name)
    end
  end
end

return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      ensure_installed(opts, { "marksman", "markdownlint-cli2", "prettier" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = { "markdownlint-cli2" }
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.markdown = { "prettier" }
      opts.formatters_by_ft["markdown.mdx"] = { "prettier" }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      -- markdown viewer가 Mermaid fenced block을 diagram으로 렌더링하게 둔다.
      -- 예: ```mermaid 또는 첫 줄이 graph/sequenceDiagram/erDiagram/gantt인 fenced block.
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {
          securityLevel = "strict",
        },
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }

      -- markdown 파일에서만 preview 명령/키맵을 노출한다.
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      {
        "<leader>cp",
        "<cmd>MarkdownPreviewToggle<cr>",
        ft = "markdown",
        desc = "Markdown Preview",
      },
    },
    ft = { "markdown" },
  },
}
