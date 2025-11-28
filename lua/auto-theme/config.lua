---@class AutoThemeConfig
---@field dark? string Dark theme name
---@field light? string Light theme name

local M = {}

local defaults = {
  dark = 'default',
  light = 'default',
}

function M.get()
  return {
    dark = vim.g.auto_theme_dark or defaults.dark,
    light = vim.g.auto_theme_light or defaults.light,
  }
end

function M.validate()
  local config = M.get()

  if type(config.dark) ~= 'string' then
    error('vim.g.auto_theme_dark must be a string')
  end

  if type(config.light) ~= 'string' then
    error('vim.g.auto_theme_light must be a string')
  end

  return config
end

return M
