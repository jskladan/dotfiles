require("trouble").setup({ icons = false })

function vimgrep_fixme_toggle()
    local trouble = require("trouble")
    if trouble.is_open() then
        trouble.close()
    else
        vim.cmd("silent! vimgrep FIXME\\|TODO\\C %")
        trouble.toggle("quickfix")
    end
end

vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", vimgrep_fixme_toggle)
