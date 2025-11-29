local M = {}

local logger = require('auto-theme.log')
local is_mac = vim.fn.has('mac') == 1
local is_linux = vim.fn.has('unix') == 1 and not is_mac

local job_id = nil

function M.start()
  if job_id then
    logger.debug('Watcher already running')
    return
  end

  if is_mac then
    M._start_macos_watcher()
  elseif is_linux then
    M._start_linux_watcher()
  else
    logger.log('Platform not supported', vim.log.levels.WARN)
  end
end

function M.stop()
  if job_id then
    vim.fn.jobstop(job_id)
    job_id = nil
    logger.debug('Watcher stopped')
  end
end

function M._start_macos_watcher()
  local plugin_dir = vim.fn.stdpath('data') .. '/lazy/auto-theme.nvim'
  local python_script = plugin_dir .. '/watchers/macos.py'
  if vim.fn.filereadable(python_script) == 0 then
    logger.log('macOS watcher script not found', vim.log.levels.ERROR)
    return
  end

  local env = vim.fn.environ()
  env.VIRTUAL_ENV = ''
  env.PYTHONPATH = ''
  env.CONDA_PREFIX = ''

  job_id = vim.fn.jobstart({ 'uv', 'run', python_script }, {
    cwd = plugin_dir,
    env = env,
    on_stdout = function(_, data, _)
      for _, line in ipairs(data) do
        if line ~= '' then
          logger.debug('macOS watcher: ' .. line)
          if line == 'DARK' or line == 'LIGHT' then
            require('auto-theme.themes').set_mode(line == 'DARK')
          end
        end
      end
    end,
    on_stderr = function(_, data, _)
      for _, line in ipairs(data) do
        if line ~= '' then
          logger.log('macOS watcher error: ' .. line, vim.log.levels.ERROR)
        end
      end
    end,
    on_exit = function(_, exit_code, _)
      job_id = nil
      if exit_code ~= 0 then
        logger.log('macOS watcher exited with code: ' .. exit_code, vim.log.levels.ERROR)
      end
    end,
  })

  if job_id == 0 or job_id == -1 then
    job_id = nil
    logger.log('Failed to start macOS watcher', vim.log.levels.ERROR)
  else
    logger.debug('Started macOS watcher')
  end
end

function M._start_linux_watcher()
  local plugin_dir = vim.fn.stdpath('data') .. '/lazy/auto-theme.nvim'
  local python_script = plugin_dir .. '/watchers/linux.py'
  if vim.fn.filereadable(python_script) == 0 then
    logger.log('Linux watcher script not found', vim.log.levels.ERROR)
    return
  end

  local env = vim.fn.environ()
  env.VIRTUAL_ENV = ''
  env.PYTHONPATH = ''
  env.CONDA_PREFIX = ''

  job_id = vim.fn.jobstart({ 'uv', 'run', python_script }, {
    cwd = plugin_dir,
    env = env,
    on_stdout = function(_, data, _)
      for _, line in ipairs(data) do
        if line ~= '' then
          logger.debug('Linux watcher: ' .. line)
          if line == 'DARK' or line == 'LIGHT' then
            require('auto-theme.themes').set_mode(line == 'DARK')
          end
        end
      end
    end,
    on_stderr = function(_, data, _)
      for _, line in ipairs(data) do
        if line ~= '' then
          logger.log('Linux watcher error: ' .. line, vim.log.levels.ERROR)
        end
      end
    end,
    on_exit = function(_, exit_code, _)
      job_id = nil
      if exit_code ~= 0 then
        logger.log('Linux watcher exited with code: ' .. exit_code, vim.log.levels.ERROR)
      end
    end,
  })

  if job_id == 0 or job_id == -1 then
    job_id = nil
    logger.log('Failed to start Linux watcher', vim.log.levels.ERROR)
  else
    logger.debug('Started Linux watcher')
  end
end

return M
