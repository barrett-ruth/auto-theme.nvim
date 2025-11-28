local M = {}

function M.log(msg, level)
  level = level or vim.log.levels.INFO
  vim.notify('[auto-theme] ' .. msg, level)
end

function M.debug(msg)
  if vim.g.auto_theme_debug then
    M.log('[DEBUG] ' .. msg, vim.log.levels.DEBUG)
  end
end

return M
