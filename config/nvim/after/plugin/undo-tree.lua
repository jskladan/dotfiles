function undotree_smartoggle()
    if require'nvim-tree.view'.is_visible() then
        vim.cmd("NvimTreeClose")
    end
    vim.cmd("UndotreeToggle")
end

vim.cmd("let g:undotree_SetFocusWhenToggle = 1")
vim.cmd("let g:undotree_WindowLayout = 4")
vim.cmd("let g:undotree_ShortIndicators = 1")

vim.cmd([[
    function! g:Undotree_CustomMap()
        nmap <buffer> <up> <plug>UndotreeNextState
        nmap <buffer> <down> <plug>UndotreePreviousState
    endfunc
]])

-- I used this with the WindowLayout = 2 (undotree on the left) to close the possibly open nvimtree
--   not necessarily needed with layout 4, keeping for future
-- vim.keymap.set("n", "<leader>u", undotree_smartoggle)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
