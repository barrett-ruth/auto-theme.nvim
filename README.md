# auto-theme.nvim

**The only zero-polling automatic theme switcher for Neovim**

Supports Linux & macOS.

## Requirements

- Neovim >= 0.10.0
- [uv](https://docs.astral.sh/uv/) (for macOS support)
- Python >= 3.12 (for macOS support)

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'barrett-ruth/auto-theme.nvim',
  lazy = true,
  init = function()
    vim.g.auto_theme_dark = 'tokyonight'
    vim.g.auto_theme_light = 'dawn'
  end
}
```

## Configuration

```vim
:help auto-theme.nvim
```

## Documentation

## Similar Projects

- [system-theme.nvim](https://github.com/cosmicboots/system-theme.nvim)
- [auto-dark-mode.nvim](https://github.com/f-person/auto-dark-mode.nvim)
- [auto-gnome-theme.nvim](https://github.com/itsfernn/auto-gnome-theme.nvim)
- [circadian.nvim](https://github.com/gagbo/circadian.nvim)
