require('packer_config')

-- disable netrw (required for the nvim-tree plugin)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd.source("~/.vimrc")
-- vim.cmd("colorscheme rose-pine-main")

vim.cmd("colorscheme github_dark_high_contrast")

-- highlight yanked data
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false, timeout=500}]])
