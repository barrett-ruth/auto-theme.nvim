if vim.g.loaded_auto_theme then
  return
end
vim.g.loaded_auto_theme = 1

vim.api.nvim_create_user_command('AutoTheme', function(opts)
  local auto_theme = require('auto-theme')
  auto_theme.handle_command(opts)
end, {
  nargs = '*',
  desc = 'Auto theme switcher',
  complete = function(ArgLead, CmdLine, _)
    local args = vim.split(vim.trim(CmdLine), '%s+')
    local num_args = #args
    if CmdLine:sub(-1) == ' ' then
      num_args = num_args + 1
    end

    local function filter_candidates(candidates)
      return vim.tbl_filter(function(cmd)
        return cmd:find(ArgLead, 1, true) == 1
      end, candidates)
    end

    if num_args == 2 then
      return filter_candidates({ 'status', 'refresh', 'enable', 'disable' })
    end
    return {}
  end,
})
