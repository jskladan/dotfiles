require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "vimdoc", "python", "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "html" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { "python", "jinja.html" }, -- fixes https://github.com/nvim-treesitter/nvim-treesitter/issues/1573
    },
}


-- This is nasty, but could not make Treesitter+LSP behave with jinja

vim.api.nvim_create_autocmd('BufEnter', {pattern = "*.html", command="set syntax=jinja.html"})

--au BufEnter *.html set syntax=jinja.html
