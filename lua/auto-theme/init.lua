local M = {}

local config = require('auto-theme.config')
local logger = require('auto-theme.log')
local themes = require('auto-theme.themes')
local watcher = require('auto-theme.watcher')

if vim.fn.has('nvim-0.10.0') == 0 then
  logger.log('Requires nvim-0.10.0+', vim.log.levels.ERROR)
  return {}
end

local initialized = false

---@return nil
function M.handle_command(opts)
  local commands = require('auto-theme.commands')
  commands.handle_command(opts)
end

function M.setup()
  if initialized then
    return
  end

  config.validate()
  watcher.start()
  themes.apply_current()

  initialized = true
end

function M.stop()
  watcher.stop()
  initialized = false
end

function M.refresh()
  themes.apply_current()
end

function M.get_current_theme()
  return themes.get_current()
end

function M.is_initialized()
  return initialized
end

return M
