-- nvim-eta: Eta template support for Neovim
-- Main module initialization

local M = {}

-- Default configuration
M.config = {
  -- Enable Treesitter integration
  treesitter = true,
  -- Enable LSP support
  lsp = {
    html = true,
    tailwindcss = true,
    emmet = true,
  },
  -- Enable auto-closing tags
  autotag = true,
}

-- Setup function for lazy.nvim integration
function M.setup(opts)
  -- Merge user config with defaults
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  -- Register Eta filetype
  vim.filetype.add({
    extension = {
      eta = "html.eta",
    },
  })

  -- Configure Treesitter if enabled
  if M.config.treesitter then
    M.setup_treesitter()
  end

  -- Configure LSP if enabled
  if M.config.lsp then
    M.setup_lsp()
  end

  -- Configure autotag if enabled
  if M.config.autotag then
    M.setup_autotag()
  end
end

-- Setup Treesitter for Eta files
function M.setup_treesitter()
  local ok, configs = pcall(require, "nvim-treesitter.configs")
  if not ok then
    return
  end

  -- Register Eta as HTML-based parser
  vim.treesitter.language.register("html", "eta")
  vim.treesitter.language.register("html", "html.eta")
end

-- Setup LSP for Eta files
function M.setup_lsp()
  local ok, lspconfig = pcall(require, "lspconfig")
  if not ok then
    return
  end

  -- Attach HTML LSP to Eta files
  if M.config.lsp.html then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "html.eta",
      callback = function()
        vim.lsp.start({
          name = "html",
          cmd = { "vscode-html-language-server", "--stdio" },
          root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
        })
      end,
    })
  end

  -- Attach TailwindCSS LSP to Eta files
  if M.config.lsp.tailwindcss then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "html.eta",
      callback = function()
        local root_pattern = require("lspconfig.util").root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "tailwind.config.mjs",
          "tailwind.config.cjs",
          "postcss.config.js"
        )
        local root_dir = root_pattern(vim.api.nvim_buf_get_name(0))
        if root_dir then
          vim.lsp.start({
            name = "tailwindcss",
            cmd = { "tailwindcss-language-server", "--stdio" },
            root_dir = root_dir,
            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "eta", "html.eta" },
            init_options = {
              userLanguages = {
                eta = "html",
              },
            },
            settings = {
              tailwindCSS = {
                includeLanguages = {
                  eta = "html",
                  ["html.eta"] = "html",
                },
                classAttributes = { "class", "className", "classList", "ngClass" },
                lint = {
                  cssConflict = "warning",
                  invalidApply = "error",
                  invalidConfigPath = "error",
                  invalidScreen = "error",
                  invalidTailwindDirective = "error",
                  invalidVariant = "error",
                  recommendedVariantOrder = "warning",
                },
                validate = true,
                experimental = {
                  classRegex = {
                    { "class[:]\\s*['\"]([^'\"]*)['\"]", "['\"]([^'\"]*)['\"]" },
                    { "class[:]\\s*{([^}]*)}", "['\"]([^'\"]*)['\"]" },
                    { "className[:]\\s*['\"]([^'\"]*)['\"]", "['\"]([^'\"]*)['\"]" },
                  },
                },
              },
            },
          })
        end
      end,
    })
  end

  -- Setup Emmet if enabled
  if M.config.lsp.emmet then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "html.eta",
      callback = function()
        vim.lsp.start({
          name = "emmet_ls",
          cmd = { "emmet-ls", "--stdio" },
          root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
          settings = {
            emmet = {
              includeLanguages = {
                eta = "html",
              },
            },
          },
        })
      end,
    })
  end
end

-- Setup nvim-ts-autotag integration
function M.setup_autotag()
  local ok, autotag = pcall(require, "nvim-ts-autotag")
  if not ok then
    return
  end

  -- Add Eta to autotag filetypes
  autotag.setup({
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
    filetypes = {
      "html",
      "xml",
      "eta",
      "html.eta",
    },
  })
end

return M

