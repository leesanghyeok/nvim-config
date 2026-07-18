-- mise integration — https://mise.jdx.dev/mise-cookbook/neovim.html

-- Make mise-managed tools (runtimes, LSP servers, linters, formatters) visible to Neovim and respect per-project tool versions — by prepending mise's shims to PATH.
-- The shims dir must come FIRST in PATH — ahead of the version-pinned
-- installs/<tool>/<ver>/bin dirs that `mise activate` resolved from the
-- shell's cwd when Neovim was launched. A shim re-resolves the tool version
-- from the cwd of each spawned process, so buffers from different projects
-- in one session each get their own project-pinned version (provided the
-- tool is spawned with the file's directory as cwd).
local shims = (vim.env.HOME or vim.fn.expand("~")) .. "/.local/share/mise/shims"
if vim.fn.isdirectory(shims) == 1 then
  local parts = vim.tbl_filter(function(p)
    return p ~= shims
  end, vim.split(vim.env.PATH or "", ":"))
  vim.env.PATH = shims .. ":" .. table.concat(parts, ":")
end

return {
  -- mason prepends its bin dir to PATH by default, which shadows mise-managed
  -- tools that mason also installs. Append instead so mise (and other system)
  -- tools win and mason only fills the gaps.
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = { PATH = "append" },
  },
}
