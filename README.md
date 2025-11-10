# nvim-eta

Полноценная поддержка шаблонов [Eta](https://eta.js.org/) в Neovim с подсветкой синтаксиса, Treesitter, LSP и автозакрытием тегов.

## Возможности

- ✅ **Автоматическое определение filetype** (`html.eta`) для `.eta` файлов
- ✅ **Подсветка синтаксиса** для HTML и JavaScript внутри тегов Eta (`<% %>`, `<%= %>`)
- ✅ **Treesitter интеграция** с language injections для JavaScript и HTML
- ✅ **LSP поддержка**:
  - HTML Language Server
  - TailwindCSS IntelliSense
  - Emmet
- ✅ **Автозакрытие тегов** через `nvim-ts-autotag`
- ✅ **Простая настройка** через `lazy.nvim`

## Установка

### Требования

- Neovim >= 0.9.0
- [lazy.nvim](https://github.com/folke/lazy.nvim) (рекомендуется)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (опционально)
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) (опционально)
- LSP серверы (опционально):
  - `vscode-html-language-server` (HTML)
  - `tailwindcss-language-server` (TailwindCSS)
  - `emmet-ls` (Emmet)

### lazy.nvim

```lua
-- ~/.config/nvim/lua/plugins/eta.lua
return {
  "yourusername/nvim-eta",
  ft = "eta",  -- Ленивая загрузка только для .eta файлов
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-eta").setup({
      -- Опции по умолчанию (можно не указывать)
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

### Ручная установка

```bash
git clone https://github.com/yourusername/nvim-eta ~/.local/share/nvim/site/pack/plugins/start/nvim-eta
```

Добавьте в `init.lua`:

```lua
require("nvim-eta").setup()
```

## Конфигурация

### Опции по умолчанию

```lua
require("nvim-eta").setup({
  -- Включить Treesitter интеграцию
  treesitter = true,
  
  -- LSP настройки
  lsp = {
    html = true,         -- HTML Language Server
    tailwindcss = true,  -- TailwindCSS IntelliSense
    emmet = true,        -- Emmet abbreviations
  },
  
  -- Автозакрытие тегов
  autotag = true,
})
```

### Отключение отдельных функций

```lua
-- Только подсветка синтаксиса, без LSP и Treesitter
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

### Кастомная конфигурация для LazyVim

Если используете [LazyVim](https://github.com/LazyVim/LazyVim), создайте файл:

```lua
-- ~/.config/nvim/lua/plugins/eta.lua
return {
  "yourusername/nvim-eta",
  ft = "eta",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "windwp/nvim-ts-autotag",
  },
  opts = {
    -- LazyVim использует opts вместо config
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

## Синтаксис Eta

Плагин поддерживает все типы тегов Eta:

```html
<!-- Выполнение кода -->
<% const name = "World"; %>

<!-- Вывод с экранированием -->
<p>Hello, <%= name %>!</p>

<!-- Вывод без экранирования -->
<div><%~ rawHTML %></div>

<!-- Комментарии -->
<%# Это комментарий, не попадёт в вывод %>

<!-- Сырой вывод -->
<%_ "Raw output without trimming" %>

<!-- Условия и циклы -->
<% if (user.isAdmin) { %>
  <button>Admin Panel</button>
<% } %>

<% users.forEach(user => { %>
  <li><%= user.name %></li>
<% }) %>
```

## Особенности

### Treesitter

Плагин использует HTML Treesitter parser с language injection для JavaScript блоков. Это обеспечивает:

- Точную подсветку синтаксиса
- Навигацию по коду (gd, gD)
- Refactoring с помощью Treesitter

### LSP

Автоматически подключает LSP серверы для `.eta` файлов:

- **HTML LS**: автодополнение HTML тегов, валидация
- **TailwindCSS**: IntelliSense для Tailwind классов
- **Emmet**: сокращения (например, `div.container>ul>li*3`)

### Autotag

Интеграция с `nvim-ts-autotag`:

- Автозакрытие при вводе `<div>` → `<div>|</div>`
- Синхронное переименование открывающих/закрывающих тегов
- Автозакрытие при вводе `/`

## Установка LSP серверов

### Mason (рекомендуется)

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

## Совместимость

Плагин протестирован с:

- Neovim 0.9.0+
- LazyVim
- nvim-treesitter
- nvim-lspconfig
- nvim-ts-autotag

## Troubleshooting

### Не работает подсветка синтаксиса

1. Проверьте, что filetype установлен: `:set filetype?` → должно быть `html.eta`
2. Убедитесь, что плагин загружен: `:lua print(vim.g.loaded_nvim_eta)` → должно быть `1`

### LSP не запускается

1. Проверьте наличие LSP серверов: `which vscode-html-language-server`
2. Проверьте логи LSP: `:LspLog`
3. Проверьте, что LSP включен в конфигурации плагина

### Treesitter не работает

1. Установите HTML parser: `:TSInstall html`
2. Убедитесь, что язык зарегистрирован: `:lua print(vim.treesitter.language.get_lang("eta"))` → `html`

## Разработка

```bash
# Клонировать репозиторий
git clone https://github.com/yourusername/nvim-eta
cd nvim-eta

# Запустить Neovim с локальной версией
nvim --cmd "set rtp+=."
```

## Лицензия

MIT

## Авторы

Создано для упрощения работы с Eta шаблонами в Neovim.

## Благодарности

- [Eta.js](https://eta.js.org/) - быстрый шаблонизатор
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - парсинг синтаксиса
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - автозакрытие тегов

