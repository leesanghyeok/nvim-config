-- Inline image rendering via the Kitty Graphics Protocol (Ghostty/kitty/wezterm)
-- ImageMagick is required to display formats other than PNG
return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        doc = {
          -- markdown의 mermaid/math/image block 위에서 커서 이동만으로
          -- floating image preview가 뜨지 않게 한다.
          enabled = false,
          inline = false,
          float = false,
        },
      },
    },
  },
}
