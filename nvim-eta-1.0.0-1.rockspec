-- Rockspec for nvim-eta plugin
rockspec_format = "3.0"
package = "nvim-eta"
version = "1.0.0-1"

source = {
  url = "git+https://github.com/yourusername/nvim-eta.git",
  tag = "v1.0.0"
}

description = {
  summary = "Eta template support for Neovim",
  detailed = [[
    Full-featured Eta (JavaScript templates) support for Neovim including:
    - Automatic filetype detection for .eta files
    - Syntax highlighting for HTML and JavaScript
    - Treesitter integration with language injection
    - LSP support (HTML, TailwindCSS, Emmet)
    - Auto-closing tags via nvim-ts-autotag
  ]],
  homepage = "https://github.com/yourusername/nvim-eta",
  license = "MIT"
}

dependencies = {
  "lua >= 5.1",
}

build = {
  type = "builtin",
  modules = {
    ["nvim-eta"] = "lua/nvim-eta/init.lua",
  },
  copy_directories = {
    "ftdetect",
    "syntax",
    "plugin",
    "queries",
  }
}

