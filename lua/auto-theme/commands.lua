local M = {}

local logger = require('auto-theme.log')

function M.handle_command(opts)
  local args = opts.fargs
  local cmd = args[1] or 'status'

  local auto_theme = require('auto-theme')
  local themes = require('auto-theme.themes')
  local watcher = require('auto-theme.watcher')

  if cmd == 'status' then
    local current = themes.get_current()
    local config = require('auto-theme.config').get()
    logger.log(
      string.format('Current: %s | Dark: %s | Light: %s', current, config.dark, config.light)
    )
  elseif cmd == 'refresh' then
    themes.apply_current()
    logger.log('Theme refreshed')
  elseif cmd == 'enable' then
    auto_theme.setup()
    logger.log('Auto theme enabled')
  elseif cmd == 'disable' then
    auto_theme.stop()
    logger.log('Auto theme disabled')
  else
    logger.log('Unknown command: ' .. cmd, vim.log.levels.ERROR)
  end
end

return M
