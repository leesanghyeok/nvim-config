local neotree_focus_ns = vim.api.nvim_create_namespace("StarkNeoTreeFocus")
local neotree_focus_file

local function mark_neotree_focus(state)
  if not state.bufnr or not vim.api.nvim_buf_is_valid(state.bufnr) or not state.tree then
    return
  end

  vim.api.nvim_buf_clear_namespace(state.bufnr, neotree_focus_ns, 0, -1)
  if not neotree_focus_file then
    return
  end

  if not state.winid or not vim.api.nvim_win_is_valid(state.winid) then
    return
  end

  local line = vim.api.nvim_win_get_cursor(state.winid)[1]
  vim.api.nvim_buf_set_extmark(state.bufnr, neotree_focus_ns, line - 1, 0, {
    line_hl_group = "NeoTreeCursorLine",
  })
end

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
    init = function()
      local function set_neotree_highlights()
        -- Files 탭에서 현재 버퍼로 reveal된 행이 inactive window에서도 분명히 보이게 한다.
        vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#3a3f4b", bold = true })
      end

      set_neotree_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("StarkNeoTreeHighlights", { clear = true }),
        callback = set_neotree_highlights,
      })
    end,
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

            neotree_focus_file = file
            if state.bufnr and vim.api.nvim_buf_is_valid(state.bufnr) then
              vim.api.nvim_buf_clear_namespace(state.bufnr, neotree_focus_ns, 0, -1)
            end

            require("neo-tree.command").execute({
              source = "filesystem",
              action = "show",
              position = state.current_position or "left",
              dir = state.path,
              reveal_file = file,
            })
            vim.defer_fn(function()
              mark_neotree_focus(manager.get_state("filesystem"))
            end, 1200)
          end,
        },
        {
          event = "neo_tree_buffer_enter",
          handler = function(args)
            local bufnr = args and args.bufnr or vim.api.nvim_get_current_buf()
            neotree_focus_file = nil
            if vim.api.nvim_buf_is_valid(bufnr) then
              vim.api.nvim_buf_clear_namespace(bufnr, neotree_focus_ns, 0, -1)
            end
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
