require("trouble").setup()

function vimgrep_fixme_toggle()
    local trouble = require("trouble")
    if trouble.is_open() then
        trouble.close()
    else
        vim.cmd("silent! vimgrep FIXME\\|TODO\\C %")
        trouble.toggle("quickfix")
        trouble.focus()
    end
end

vim.keymap.set("n", "<leader>xx", function() vim.cmd [[Trouble diagnostics toggle focus=true filter.buf=0]] end)
vim.keymap.set("n", "<leader>xa", function() vim.cmd [[Trouble diagnostics toggle focus=true]] end)
vim.keymap.set("n", "<leader>xd", vimgrep_fixme_toggle)
