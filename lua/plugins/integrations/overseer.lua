return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerClose",
      "OverseerOpen",
      "OverseerRun",
      "OverseerShell",
      "OverseerTaskAction",
      "OverseerToggle",
    },
    keys = {
      { "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
      { "<leader>tc", "<cmd>OverseerShell<cr>", desc = "Run Command" },
      { "<leader>tt", "<cmd>OverseerToggle<cr>", desc = "Toggle Tasks" },
      { "<leader>ta", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
    },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 12,
        max_height = 20,
        default_detail = 1,
      },
    },
  },
}
