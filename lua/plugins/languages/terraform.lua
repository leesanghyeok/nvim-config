-- terraform/hcl language tooling is provided by the official
-- lazyvim.plugins.extras.lang.terraform extra (imported in config.lazy):
-- treesitter parsers, terraformls, tflint (mason), terraform_fmt (conform.nvim)
-- and terraform_validate (nvim-lint).
--
-- Neovim's bundled ftplugins (ftplugin/terraform.vim, sourced by
-- ftplugin/hcl.vim) already set commentstring=# %s, but it is kept here
-- explicitly so the behaviour is visible in this config.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "hcl", "terraform" },
  desc = "terraform/hcl commentstring configuration",
  command = "setlocal commentstring=#\\ %s",
})

-- terraformls reports "provider not found" diagnostics until the module dir
-- has been initialized. Auto-run `terraform init` in the background the first
-- time a buffer from an uninitialized dir is opened, once per dir per session.
-- -backend=false: provider schemas are all the LSP needs; skipping backend
-- setup avoids touching remote state / credential prompts from a background
-- job (a manual `terraform init` is still needed before plan/apply).
local tf_init_started = {}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "terraform", "terraform-vars" },
  desc = "background terraform init for uninitialized module dirs",
  callback = function(ev)
    local name = vim.api.nvim_buf_get_name(ev.buf)
    if name == "" or name:find("^%w+://") then
      return
    end
    local dir = vim.fs.dirname(name)
    if tf_init_started[dir] then
      return
    end
    tf_init_started[dir] = true
    if (vim.uv or vim.loop).fs_stat(dir .. "/.terraform") or vim.fn.executable("terraform") == 0 then
      return
    end
    vim.notify("terraform init started (background): " .. dir, vim.log.levels.INFO, { title = "terraform" })
    vim.system(
      { "terraform", "init", "-upgrade", "-backend=false", "-input=false", "-no-color" },
      { cwd = dir },
      function(out)
        vim.schedule(function()
          if out.code == 0 then
            vim.notify("terraform init done: " .. dir, vim.log.levels.INFO, { title = "terraform" })
            pcall(vim.cmd, "LspRestart terraformls")
          else
            vim.notify(
              "terraform init failed: " .. dir .. "\n" .. (out.stderr or ""),
              vim.log.levels.ERROR,
              { title = "terraform" }
            )
          end
        end)
      end
    )
  end,
})

return {
  -- The lang.terraform extra installs tflint via mason but only wires
  -- terraform_validate into nvim-lint, so tflint never actually runs. Add it.
  -- tflint catches provider/best-practice issues; terraform_validate (kept)
  -- covers `terraform validate` (needs an initialized dir). Both can run.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      for _, ft in ipairs({ "terraform", "tf" }) do
        local list = opts.linters_by_ft[ft] or {}
        if not vim.tbl_contains(list, "tflint") then
          table.insert(list, "tflint")
        end
        opts.linters_by_ft[ft] = list
      end
    end,
  },
}
