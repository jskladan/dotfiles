require('telescope').setup {
    defaults = {
        layout_strategy = "vertical",
        layout_config = {
            vertical = {
                preview_height = 0.60,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,             -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}

-- FZF Syntax
-- | Token     | Match type                 | Description                          |
-- | --------- | -------------------------- | ------------------------------------ |
-- | `sbtrkt`  | fuzzy-match                | Items that match `sbtrkt`            |
-- | `'wild`   | exact-match (quoted)       | Items that include `wild`            |
-- | `^music`  | prefix-exact-match         | Items that start with `music`        |
-- | `.mp3$`   | suffix-exact-match         | Items that end with `.mp3`           |
-- | `!fire`   | inverse-exact-match        | Items that do not include `fire`     |
-- | `!^music` | inverse-prefix-exact-match | Items that do not start with `music` |
-- | `!.mp3$`  | inverse-suffix-exact-match | Items that do not end with `.mp3`    |

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>fgr', function()
--     builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)
