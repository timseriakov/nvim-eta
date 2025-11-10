# nvim-eta

Comprehensive [Eta](https://eta.js.org/) template support for Neovim with syntax highlighting, Treesitter, LSP, and auto-closing tags.

## Features

- ✅ **Automatic filetype detection** (`html.eta`) for `.eta` files
- ✅ **Syntax highlighting** for HTML and JavaScript inside Eta tags (`<% %>`, `<%= %>`)
- ✅ **Treesitter integration** with language injections for JavaScript and HTML
- ✅ **LSP support**:
  - HTML Language Server
  - TailwindCSS IntelliSense
  - Emmet
- ✅ **Auto-closing tags** via `nvim-ts-autotag`
- ✅ **Easy setup** with `lazy.nvim`

## Installation

### Requirements

- Neovim >= 0.9.0
- [lazy.nvim](https://github.com/folke/lazy.nvim) (recommended)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (optional)
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) (optional)
- LSP servers (optional):
  - `vscode-html-language-server` (HTML)
  - `tailwindcss-language-server` (TailwindCSS)
  - `emmet-ls` (Emmet)

### lazy.nvim

```lua
-- ~/.config/nvim/lua/plugins/eta.lua
return {
  "timseriakov/nvim-eta",
  ft = "eta",  -- Lazy load only for .eta files
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-eta").setup({
      -- Default options (can be omitted)
      treesitter = true,
      lsp = {
        html = true,
        tailwindcss = true,
        emmet = true,
      },
      autotag = true,
    })
  end,
}
```

### Manual Installation

```bash
git clone https://github.com/timseriakov/nvim-eta ~/.local/share/nvim/site/pack/plugins/start/nvim-eta
```

Add to `init.lua`:

```lua
require("nvim-eta").setup()
```

## Configuration

### Default Options

```lua
require("nvim-eta").setup({
  -- Enable Treesitter integration
  treesitter = true,
  
  -- LSP settings
  lsp = {
    html = true,         -- HTML Language Server
    tailwindcss = true,  -- TailwindCSS IntelliSense
    emmet = true,        -- Emmet abbreviations
  },
  
  -- Auto-closing tags
  autotag = true,
})
```

### Disable Specific Features

```lua
-- Only syntax highlighting, no LSP or Treesitter
require("nvim-eta").setup({
  treesitter = false,
  lsp = {
    html = false,
    tailwindcss = false,
    emmet = false,
  },
  autotag = false,
})
```

### Custom Configuration for LazyVim

If using [LazyVim](https://github.com/LazyVim/LazyVim), create a file:

```lua
-- ~/.config/nvim/lua/plugins/eta.lua
return {
  "timseriakov/nvim-eta",
  ft = "eta",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "windwp/nvim-ts-autotag",
  },
  opts = {
    -- LazyVim uses opts instead of config
    treesitter = true,
    lsp = {
      html = true,
      tailwindcss = true,
      emmet = true,
    },
    autotag = true,
  },
}
```

## Eta Syntax

The plugin supports all Eta tag types:

```html
<!-- Code execution -->
<% const name = "World"; %>

<!-- Escaped output -->
<p>Hello, <%= name %>!</p>

<!-- Raw output (unescaped) -->
<div><%~ rawHTML %></div>

<!-- Comments -->
<%# This is a comment, won't appear in output %>

<!-- Raw output without trimming -->
<%_ "Raw output without trimming" %>

<!-- Conditionals and loops -->
<% if (user.isAdmin) { %>
  <button>Admin Panel</button>
<% } %>

<% users.forEach(user => { %>
  <li><%= user.name %></li>
<% }) %>
```

## Features

### Treesitter

The plugin uses HTML Treesitter parser with language injection for JavaScript blocks. This provides:

- Accurate syntax highlighting
- Code navigation (gd, gD)
- Refactoring with Treesitter

### LSP

Automatically attaches LSP servers for `.eta` files:

- **HTML LS**: HTML tag autocompletion, validation
- **TailwindCSS**: IntelliSense for Tailwind classes
- **Emmet**: abbreviations (e.g., `div.container>ul>li*3`)

### Autotag

Integration with `nvim-ts-autotag`:

- Auto-close when typing `<div>` → `<div>|</div>`
- Synchronous renaming of opening/closing tags
- Auto-close when typing `/`

## Installing LSP Servers

### Mason (recommended)

```lua
-- ~/.config/nvim/lua/plugins/mason.lua
return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "html-lsp",
      "tailwindcss-language-server",
      "emmet-ls",
    },
  },
}
```

### npm

```bash
npm install -g vscode-langservers-extracted  # HTML
npm install -g @tailwindcss/language-server  # TailwindCSS
npm install -g emmet-ls                      # Emmet
```

## TailwindCSS Configuration

For TailwindCSS IntelliSense to work properly with `.eta` files, you need to configure your `tailwind.config.js` to include `.eta` files in the content paths.

### Example tailwind.config.js

```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  // IMPORTANT: Include .eta files in content paths
  content: [
    "./src/**/*.{html,js,ts,jsx,tsx,eta}",
    "./views/**/*.eta",
    "./templates/**/*.eta",
    "**/*.eta",  // Include all .eta files
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

### TypeScript config

```typescript
import type { Config } from 'tailwindcss'

export default {
  content: [
    "./src/**/*.{html,js,ts,jsx,tsx,eta}",
    "./views/**/*.eta",
    "./templates/**/*.eta",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
} satisfies Config
```

### Verify TailwindCSS is working

1. Make sure `tailwind.config.js` exists in your project root
2. Include `.eta` files in the `content` array
3. Open an `.eta` file in Neovim
4. Check LSP status: `:LspInfo` - should show `tailwindcss` attached
5. Try typing a class: `<div class="bg-` → IntelliSense should appear with custom colors/classes

**Note**: If you have custom theme configuration (colors, spacing, etc.), TailwindCSS LSP will now suggest those custom values along with the default ones.

## Compatibility

Tested with:

- Neovim 0.9.0+
- LazyVim
- nvim-treesitter
- nvim-lspconfig
- nvim-ts-autotag

## Troubleshooting

### Syntax highlighting not working

1. Check filetype is set: `:set filetype?` → should be `html.eta`
2. Verify plugin loaded: `:lua print(vim.g.loaded_nvim_eta)` → should be `1`

### LSP not starting

1. Check LSP servers installed: `which vscode-html-language-server`
2. Check LSP logs: `:LspLog`
3. Verify LSP enabled in plugin configuration

### TailwindCSS IntelliSense not working

1. **Check config file exists**: `ls tailwind.config.js` or `ls tailwind.config.ts`
2. **Add .eta to content paths**:
   ```javascript
   content: ["**/*.eta", "./views/**/*.eta"]
   ```
3. **Verify LSP attached**: `:LspInfo` → should show `tailwindcss` in attached clients
4. **Check root directory**: LSP looks for config in project root. If config is nested, move it to root.
5. **Restart LSP**: `:LspRestart`
6. **Check logs**: `:LspLog` for TailwindCSS errors

### TailwindCSS shows only basic classes (not reading config)

This usually means the config file isn't being detected or parsed correctly:

1. **Ensure config is in project root** (same directory as `.git/`)
2. **Check config syntax** - make sure it's valid JavaScript/TypeScript
3. **Include .eta in content paths** - see [TailwindCSS Configuration](#tailwindcss-configuration)
4. **Restart Neovim** after changing config
5. **Check LSP settings**: `:lua vim.print(vim.lsp.get_active_clients()[1].config.settings)` (replace `[1]` with TailwindCSS client index from `:LspInfo`)

### Treesitter not working

1. Install HTML parser: `:TSInstall html`
2. Verify language registered: `:lua print(vim.treesitter.language.get_lang("eta"))` → `html`

## Development

```bash
# Clone repository
git clone https://github.com/timseriakov/nvim-eta
cd nvim-eta

# Run Neovim with local version
nvim --cmd "set rtp+=."
```

## License

MIT

## Authors

Created to simplify working with Eta templates in Neovim.

## Acknowledgments

- [Eta.js](https://eta.js.org/) - fast template engine
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - syntax parsing
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - auto-closing tags

