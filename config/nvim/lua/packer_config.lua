-- https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
    local fn = vim.fn
    local install_dir = fn.stdpath('data') .. '/site/pack/packer/start'
    fn.mkdir(install_dir, "p")
    local install_path = install_dir .. '/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()


-- Only required if you have packer configured as `opt`
--vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- use 'folke/neodev.nvim'
    -- use '/Users/jskladan/Devel/whid'

    -- Fuzzy file finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Syntax tree parser (-> better highlighting)
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use { 'nvim-treesitter/playground' }

    -- themes
    use { '/users/jskladan/devel/kanagawa.nvim' }

    -- Configurable status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- File browser
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        }
    }

    -- Keeps undo history with branches
    use { 'mbbill/undotree' }

    -- Saves cursor position in files on close/reopen
    use { 'farmergreg/vim-lastplace' }
    --[[
    use {'kitta65/signbar.nvim'}
    use {'chentoast/marks.nvim'}
    --]]

    use { 'tpope/vim-surround' }

    -- Keeps cursor in the middle of the screen
    use { 'vim-scripts/scrollfix' }


    -- Todo List, Error list, ...
    use { "folke/trouble.nvim",
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        }
    }

    -- Diffview
    use { "sindrets/diffview.nvim" }

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { "jay-babu/mason-null-ls.nvim" },
            { "jose-elias-alvarez/null-ls.nvim" },
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },

            -- snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
            { 'saadparwaiz1/cmp_luasnip' },

            -- "nicer" lsp complete floating window
            { 'onsails/lspkind.nvim' },
        }
    }

    -- Better Python indenting
    -- might not be necessary: https://stackoverflow.com/a/75015253
    use { 'Vimjas/vim-python-pep8-indent' }

    -- use { 'mitsuhiko/vim-jinja' }
    use { 'Glench/Vim-Jinja2-Syntax' }
    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
