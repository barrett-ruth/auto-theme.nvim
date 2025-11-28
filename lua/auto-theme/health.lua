local M = {}

function M.check()
  vim.health.start('auto-theme.nvim')

  if vim.fn.has('nvim-0.10.0') == 1 then
    vim.health.ok('Neovim version >= 0.10.0')
  else
    vim.health.error('Neovim version < 0.10.0')
  end

  local config = require('auto-theme.config')
  local ok, cfg = pcall(config.validate)
  if ok then
    vim.health.ok('Configuration valid')
    vim.health.info('Dark theme: ' .. cfg.dark)
    vim.health.info('Light theme: ' .. cfg.light)
  else
    vim.health.error('Invalid configuration', tostring(cfg))
  end

  local is_mac = vim.fn.has('mac') == 1
  local is_linux = vim.fn.has('unix') == 1 and not is_mac

  if is_mac then
    vim.health.ok('macOS platform detected')
    local python_script = vim.fn.stdpath('data') .. '/lazy/auto-theme.nvim/watchers/macos.py'
    if vim.fn.filereadable(python_script) == 1 then
      vim.health.ok('macOS watcher script found')
    else
      vim.health.warn('macOS watcher script not found')
    end

    local handle = io.popen('uv --version 2>&1')
    if handle then
      local result = handle:read('*a')
      handle:close()
      if result:find('uv') then
        vim.health.ok('uv found: ' .. vim.trim(result))
      else
        vim.health.error('uv not found')
      end
    end
  elseif is_linux then
    vim.health.ok('Linux platform detected')
    vim.health.info('Linux watcher will be implemented in pure Lua')
  else
    vim.health.warn('Unsupported platform')
  end

  local themes = require('auto-theme.themes')
  local current = themes.get_current()
  vim.health.info('Current system theme: ' .. current)
end

return M
