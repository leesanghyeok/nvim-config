local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Use neo-tree as the one and only file explorer.
-- LazyVim auto-selects snacks.explorer for installs with install_version >= 8
-- (see lazyvim.json), which would open *alongside* the custom neo-tree config
-- in plugins/editor.lua — two explorers when running `nvim <dir>`. Pinning the
-- explorer here (before lazy.setup, so LazyVim reads it while resolving its
-- plugin spec) keeps neo-tree and disables snacks.explorer.
vim.g.lazyvim_explorer = "neo-tree"

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.ai.copilot" },
    { import = "lazyvim.plugins.extras.ai.avante" },
    -- import/override with your plugins

    --- UI
    { import = "plugins.ui.bufferline" },
    { import = "plugins.ui.colorschemes" },
    { import = "plugins.ui.dashboard" },

    --- MISC
    { import = "plugins.diagnostics" },
    { import = "plugins.editor" },
    { import = "plugins.image" },

    --- Git
    { import = "plugins.git" },

    --- Languages
    { import = "plugins.languages.lua" },
    { import = "plugins.languages.yaml" },

    --- AI
    { import = "plugins.ai.avante" },
    { import = "plugins.ai.codecompanion" },
    { import = "plugins.ai.copilot" },

    --- Integrations
    { import = "plugins.integrations.mise" },
    { import = "plugins.integrations.overseer" },
    { import = "plugins.integrations.wakatime" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
