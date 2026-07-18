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
  {
    "3rd/diagram.nvim",
    ft = { "markdown" },
    dependencies = {
      {
        "3rd/image.nvim",
        build = false,
        opts = {
          backend = "kitty",
          processor = "magick_cli",
          integrations = {
            markdown = {
              enabled = false,
            },
          },
        },
      },
    },
    opts = {
      events = {
        -- render-markdown.nvim과 동시에 자동 extmark를 많이 만들지 않도록 수동 렌더링만 쓴다.
        render_buffer = {},
        clear_buffer = { "BufLeave" },
      },
      renderer_options = {
        mermaid = {
          theme = "dark",
          scale = 2,
        },
      },
    },
    keys = {
      {
        "<leader>cm",
        function()
          require("diagram").show_diagram_hover()
        end,
        ft = "markdown",
        desc = "Markdown Mermaid Diagram",
      },
    },
  },
}
