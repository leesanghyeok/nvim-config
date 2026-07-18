return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- not strictly required, but recommended
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    cmd = "Neotree",
    keys = {
      {
        "<F11>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = LazyVim.root(),
          })
        end,
        desc = "NeoTree File Explorer (root dir)",
      },
      {
        "<LocalLeader><F11>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            position = "float",
            dir = LazyVim.root(),
          })
        end,
        desc = "NeoTree File Explorer (root dir)",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    opts = {
      -- Close Neo-tree if it is the last window left in the tab
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      event_handlers = {
        {
          event = "vim_buffer_enter",
          handler = function(args)
            local utils = require("neo-tree.utils")
            local manager = require("neo-tree.sources.manager")
            local renderer = require("neo-tree.ui.renderer")

            if not utils.is_real_file(args.afile) then
              return
            end

            local state = manager.get_state("filesystem")
            local file = utils.normalize_path(args.afile)
            if not state.path or not renderer.window_exists(state) or not utils.is_subpath(state.path, file) then
              return
            end

            require("neo-tree.command").execute({
              source = "filesystem",
              action = "show",
              position = state.current_position or "left",
              dir = state.path,
              reveal_file = file,
            })
          end,
        },
      },
      filesystem = {
        -- 2-way binding between vim's cwd and neo-tree's root
        bind_to_cwd = false,
        filtered_items = {
          -- Display differently than normal items
          visible = true,
          hide_dotfiles = true,
          hide_gitignored = false,
        },
        follow_current_file = {
          -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
          enabled = true,
          -- 버퍼 이동으로 현재 파일을 reveal할 때 접힌 부모 디렉터리를 다시 열어둔다.
          leave_dirs_open = true,
        },
      },
      popup_border_style = "NC",
      sort_case_insensitive = false,
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      source_selector = {
        -- toggle to show selector on winbar
        winbar = true,
        -- toggle to show selector on statusline
        statusline = true,
        tabs_layout = "equal",

        highlight_tab = "NeoTreeTabInactive",
        highlight_tab_active = "NeoTreeTabActive",
        highlight_background = "NeoTreeTabInactive",
        highlight_separator = "NeoTreeTabSeparatorInactive",
        highlight_separator_active = "NeoTreeTabSeparatorActive",
      },
      window = {
        mappings = {
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = true,
              -- Snacks image hijacks image buffers, so previews of image
              -- files render via the kitty graphics protocol as well
              use_snacks_image = true,
              title = "Neo-tree Preview",
            },
          },
        },
      },
    },
  },
}
