# auto-theme.nvim

Zero-polling automatic theme switching for Neovim.

## Features

- Zero polling: Uses native OS events for instant theme switching
- Cross-platform: macOS and Linux support
- Simple configuration: Just set your preferred themes via `vim.g` variables
- Lightweight: Minimal overhead with event-driven architecture

## Requirements

- Neovim >= 0.10.0
- [uv](https://docs.astral.sh/uv/) (for macOS support)
- Python >= 3.12 (for macOS support)

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'barrett-ruth/auto-theme.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.auto_theme_dark = 'tokyonight'
    vim.g.auto_theme_light = 'dawn'
    require('auto-theme').setup()
  end
}
```

## Configuration

```lua
vim.g.auto_theme_dark = 'tokyonight'
vim.g.auto_theme_light = 'dawn'
vim.g.auto_theme_debug = true

require('auto-theme').setup()
```

## Commands

- `:AutoTheme status` - Show current theme and configuration
- `:AutoTheme refresh` - Manually refresh theme based on system preference
- `:AutoTheme enable` - Enable automatic theme switching
- `:AutoTheme disable` - Disable automatic theme switching

## How It Works

### macOS

Uses `NSDistributedNotificationCenter` to listen for `AppleInterfaceThemeChangedNotification` events.

### Linux

Subscribes to D-Bus signals from `org.freedesktop.portal.Settings` for color-scheme changes.

## License

MIT
