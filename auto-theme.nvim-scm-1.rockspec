rockspec_format = "3.0"
package = "auto-theme.nvim"
version = "scm-1"
source = {
  url = "git+https://github.com/barrett-ruth/auto-theme.nvim",
}
dependencies = {
  "lua >= 5.1",
}
test_dependencies = {}
build = {
  type = "builtin",
  copy_directories = {
    "doc",
    "plugin",
  },
}
description = {
  summary = "Zero-polling automatic theme switching for Neovim",
  detailed = [[
    auto-theme.nvim automatically switches your Neovim theme based on your
    system's dark/light mode preference using native OS events.
  ]],
  homepage = "https://github.com/barrett-ruth/auto-theme.nvim",
  license = "MIT",
}