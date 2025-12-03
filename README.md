# auto-theme.nvim

**The only zero-polling automatic theme switcher for Neovim**

https://github.com/user-attachments/assets/cc3a93d3-0ed2-448f-b97e-a133de769626

Supports Linux & macOS.

> Note, [as of
> v0.11.5](https://github.com/neovim/neovim/commit/d460928263d0ff53283f301dfcb85f5b6e17d2ac),
> NeoVim dynamically switches `vim.o.background` according to the system
> theme. This plugin may be
> replaceable with an autocmd on `OptionSet` with pattern `background`. Use at
> your own discretion.

## Requirements

- Neovim >= 0.10.0
- [uv](https://docs.astral.sh/uv/)
- Python >= 3.12

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'barrett-ruth/auto-theme.nvim',
  build = 'uv sync',
  init = function()
    vim.g.auto_theme_dark = 'tokyonight'
    vim.g.auto_theme_light = 'dawn'
  end
}
```

> NOTE: Your theme must be loaded _before_ auto-theme.nvim is.

## Documentation

```vim
:help auto-theme
```

## Similar Projects

- [system-theme.nvim](https://github.com/cosmicboots/system-theme.nvim)
- [auto-dark-mode.nvim](https://github.com/f-person/auto-dark-mode.nvim)
- [auto-gnome-theme.nvim](https://github.com/itsfernn/auto-gnome-theme.nvim)
- [circadian.nvim](https://github.com/gagbo/circadian.nvim)
