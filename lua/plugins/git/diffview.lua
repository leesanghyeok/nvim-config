return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "Repo History" },
      { "<leader>gdm", "<cmd>DiffviewOpen origin/HEAD...HEAD<cr>", desc = "Branch Diff" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        file_history = {
          layout = "diff2_horizontal",
        },
      },
    },
  },
}
