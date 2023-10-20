require('packer_config')

-- disable netrw (required for the nvim-tree plugin)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd.source("~/.vimrc")
-- vim.cmd("colorscheme rose-pine-main")

vim.cmd("colorscheme github_dark_high_contrast")

-- highlight yanked data
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false, timeout=500}]])

-- Jump to last accessed window on closing the current one
WinCloseJmp = function ()
  -- Exclude floating windows
  if '' ~= vim.api.nvim_win_get_config(0).relative then return end
  -- Record the window we jump from (previous) and to (current)
  if nil == vim.t.winid_rec then
    vim.t.winid_rec = { prev = vim.fn.win_getid(), current = vim.fn.win_getid() }
  else
    vim.t.winid_rec = { prev = vim.t.winid_rec.current, current = vim.fn.win_getid() }
  end

  -- Loop through all windows to check if the previous one has been closed
  for winnr=1,vim.fn.winnr('$') do
    if vim.fn.win_getid(winnr) == vim.t.winid_rec.prev then
      return        -- Return if previous window is not closed
    end
  end

  vim.cmd [[ wincmd p ]]
end

vim.cmd [[ autocmd VimEnter,WinEnter * lua WinCloseJmp() ]]
