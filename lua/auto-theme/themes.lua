local M = {}

local config = require('auto-theme.config')
local logger = require('auto-theme.log')

local current_mode = nil

function M.get_system_mode()
  if vim.fn.has('mac') == 1 then
    local handle = io.popen('defaults read -g AppleInterfaceStyle 2>/dev/null')
    if handle then
      local result = handle:read('*a')
      handle:close()
      return vim.trim(result) == 'Dark'
    end
  elseif vim.fn.has('unix') == 1 then
    -- Try freedesktop portal color-scheme first (most universal)
    local handle = io.popen(
      'gdbus call --session --dest org.freedesktop.portal.Desktop --object-path /org/freedesktop/portal/desktop --method org.freedesktop.portal.Settings.Read "org.freedesktop.appearance" "color-scheme" 2>/dev/null'
    )
    if handle then
      local result = handle:read('*a')
      handle:close()
      -- Output format: (<<uint32 1>>,) for dark, (<<uint32 0>>,) for light
      local value = result:match('uint32%s+(%d+)')
      if value then
        return value == '1'
      end
    end

    -- Fallback to gsettings gtk-theme check
    handle = io.popen('gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null')
    if handle then
      local result = handle:read('*a'):lower()
      handle:close()
      return result:find('dark') ~= nil
    end
  end
  return true
end

function M.set_mode(is_dark)
  current_mode = is_dark and 'dark' or 'light'
  M.apply_theme(current_mode)
end

function M.apply_theme(mode)
  local cfg = config.get()
  local theme = mode == 'dark' and cfg.dark or cfg.light

  vim.o.background = mode
  if theme ~= 'default' then
    local ok, err = pcall(vim.cmd.colorscheme, theme)
    if not ok then
      logger.log('Failed to apply theme ' .. theme .. ': ' .. tostring(err), vim.log.levels.ERROR)
    else
      logger.debug('Applied ' .. mode .. ' theme: ' .. theme)
    end
  end
end

function M.apply_current()
  local is_dark = M.get_system_mode()
  M.set_mode(is_dark)
end

function M.get_current()
  return current_mode or (M.get_system_mode() and 'dark' or 'light')
end

return M
