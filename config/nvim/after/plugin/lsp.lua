-- require("neodev").setup({})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gb", "<C-o>")
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'html', 'pyright' },
    handlers = {
        lsp_zero.default_setup,
    },
})

require("mason-null-ls").setup({
    ensure_installed = { "black", "isort" }
})



local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
    },
})


require 'lspconfig'.html.setup {
    filetypes = { "html", "jinja.html", "jinja" },
}

require 'lspconfig'.pyright.setup { settings = {
    pyright = { autoImportCompletion = true, },
    python = {
        analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
            typeCheckingMode = 'off'
        }
    }
} }

-- remap buffer formatting shortcut
vim.keymap.set('n', '==', vim.lsp.buf.format)


-- do not show diagnostics "in line", only use signs/underline
-- Diagnostics are shown using nvim-trouble plugin
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics,
--     {
--         virtual_text = false,
--         signs = true,
--         update_in_insert = false,
--         underline = true,
--     }
-- )


-- nvim-cmp is the "suggestion/autocomplete" plugin
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

-- load the vscode-style code snippets. Lazy load makes it "faster" to open files.
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    completion = {
        autocomplete = false, -- Dont auto popup
    },
    -- suggestions are generally in the sources-order
    sources = {
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        {
            name = 'buffer',
            keyword_length = 3,
            max_item_count = 10,
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end
            }
        },
    },
    sorting = {
        comparators = {
            function(...) return require('cmp_buffer'):compare_locality(...) end,
            -- The rest of your comparators...
        }
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),

    },
    formatting = {
        fields = { "kind", "abbr", "menu" },

        format = function(entry, vim_item)
            local kind    = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            -- kind.kind     = " " .. (strings[1] or "") .. " " -- window.completion.col_offset = -3
            kind.kind     = "" -- window.completion.col_offset = 0
            kind.menu     = "  (" .. (strings[2] or "") .. ") "
            return kind
        end,
    },

    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Esc to exit completion menu
        ['<Esc>'] = cmp.mapping.abort(),

        -- Use up/down to navigate inside the autocompletion window
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = 'insert' }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = 'insert' }),

        -- Ctrl+P/N to either show autocompletion window, or navigate in it if shown already
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item({ behavior = 'insert' })
            else
                cmp.complete()
            end
        end),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({ behavior = 'insert' })
            else
                cmp.complete()
            end
        end),

        -- Super Tab
        --   If the completion menu is visible it will navigate to the next item in the list.
        --   If the cursor is on top of a "snippet trigger" it'll expand it.
        --   If the cursor can jump to a snippet placeholder, it moves to it.
        --   If the cursor is in the middle of a word it displays the completion menu.
        --   Else, it acts like a regular Tab key.
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),

        -- Navigate between snippet placeholder (not necessary if using supertab, keeping for future reference)
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})
