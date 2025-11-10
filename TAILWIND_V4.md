# TailwindCSS v4 Support

Tailwind v4 uses CSS-based configuration instead of `tailwind.config.js`. This guide helps you set up TailwindCSS IntelliSense for `.eta` files with Tailwind v4.

## Quick Start

### 1. CSS Configuration

Create or update your main CSS file (e.g., `app.css` or `styles.css`):

```css
@import "tailwindcss";

/* Your custom theme */
@theme {
  --color-primary: #3b82f6;
  --color-secondary: #8b5cf6;
  --font-display: "Inter", sans-serif;
}

/* Your custom utilities */
@utility my-custom-class {
  color: var(--color-primary);
}
```

### 2. Neovim Plugin Configuration

The plugin works out of the box with Tailwind v4! Just ensure TailwindCSS LSP is installed:

```lua
return {
  "timseriakov/nvim-eta",
  ft = "eta",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-eta").setup({
      lsp = {
        tailwindcss = true,  -- Enable TailwindCSS LSP
      },
    })
  end,
}
```

### 3. LSP Configuration (Optional)

For advanced setup, you can configure TailwindCSS v4 LSP manually:

```lua
-- In your LSP config
require("lspconfig").tailwindcss.setup({
  root_dir = require("lspconfig.util").root_pattern(
    "tailwind.config.js",
    "tailwind.config.ts",
    "postcss.config.js",
    "package.json",  -- v4: looks for tailwindcss in dependencies
    "app.css",       -- v4: your main CSS file
    "styles.css"
  ),
  settings = {
    tailwindCSS = {
      experimental = {
        configFile = nil,  -- v4: no config file needed
      },
    },
  },
})
```

## Differences from v3

| Feature | Tailwind v3 | Tailwind v4 |
|---------|-------------|-------------|
| Configuration | `tailwind.config.js` | CSS `@theme` directive |
| Custom colors | `theme.extend.colors` | `@theme { --color-*: ... }` |
| Custom utilities | Plugin system | `@utility` directive |
| Content paths | `content: []` array | Automatic (scans project) |
| JIT | Optional | Always on |

## IntelliSense Features

TailwindCSS LSP with v4 provides:

- ✅ Autocomplete for all default utilities
- ✅ Custom theme variable suggestions
- ✅ Custom utility suggestions
- ✅ Color preview for custom colors
- ✅ Hover documentation
- ✅ Linting for invalid classes

## Troubleshooting

### IntelliSense not showing custom theme

1. Make sure your CSS file is in the project root or easily discoverable
2. Check that `@theme` directive is properly formatted
3. Restart LSP: `:LspRestart`

### LSP not starting

1. Verify TailwindCSS v4 is installed:
   ```bash
   npm list tailwindcss
   # Should show version 4.x.x
   ```

2. Check `package.json` has `tailwindcss`:
   ```json
   {
     "dependencies": {
       "tailwindcss": "^4.0.0"
     }
   }
   ```

3. Ensure LSP is installed:
   ```bash
   which tailwindcss-language-server
   # Or through Mason:
   :MasonInstall tailwindcss-language-server
   ```

### Custom utilities not appearing

Tailwind v4 utilities defined with `@utility` should appear automatically. If not:

1. Check CSS syntax is correct
2. Restart Neovim
3. Check LSP logs: `:LspLog`

## Example Project Structure

```
my-project/
├── package.json           # Contains "tailwindcss": "^4.0.0"
├── app.css               # Your Tailwind CSS file
├── src/
│   └── views/
│       └── index.eta     # Your Eta templates
└── .git/
```

### app.css

```css
@import "tailwindcss";

@theme {
  --color-brand: oklch(0.5 0.2 210);
  --spacing-huge: 10rem;
}

@utility card {
  background: white;
  border-radius: 0.5rem;
  padding: 1rem;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}
```

### views/index.eta

```html
<div class="card bg-brand text-white p-huge">
  <h1>Hello from Tailwind v4!</h1>
</div>
```

## Migration from v3

If you're migrating from Tailwind v3:

1. **Remove** `tailwind.config.js`
2. **Move** theme config to CSS:
   ```css
   @theme {
     /* Your extend.colors becomes --color-* */
     --color-primary: #3b82f6;
   }
   ```
3. **Convert** plugins to `@utility` directives
4. **Remove** `content` configuration (automatic in v4)

## Resources

- [Tailwind v4 Documentation](https://tailwindcss.com/docs/v4-beta)
- [Migration Guide](https://tailwindcss.com/docs/upgrade-guide)
- [CSS @theme Reference](https://tailwindcss.com/docs/theme)

