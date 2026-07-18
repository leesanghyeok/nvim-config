return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerBuild",
      "OverseerClearCache",
      "OverseerClose",
      "OverseerDeleteBundle",
      "OverseerInfo",
      "OverseerLoadBundle",
      "OverseerOpen",
      "OverseerQuickAction",
      "OverseerRun",
      "OverseerRunCmd",
      "OverseerSaveBundle",
      "OverseerTaskAction",
      "OverseerToggle",
    },
    keys = {
      { "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
      { "<leader>tc", "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
      { "<leader>tt", "<cmd>OverseerToggle<cr>", desc = "Toggle Tasks" },
      { "<leader>ta", "<cmd>OverseerQuickAction<cr>", desc = "Task Action" },
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
