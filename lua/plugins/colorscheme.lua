return {

    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
        'folke/tokyonight.nvim',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- You can configure highlights by doing something like
            vim.cmd.hi 'Comment gui=none'
        end,
    },

    {
        "nobbmaestro/nvim-andromeda",
        dependencies = {
            "tjdevries/colorbuddy.nvim",
            branch = "dev"
        },
        config = function ()
            require("andromeda").setup({
                preset = "andromeda",
                colors = {
                    -- main background
                    -- background = "#1b1e29",
                    -- background = "#2b2e39",
                    -- background = "#2f323d",
                    background = "#202436",
                    -- nvim tree active line, indent line
                    mono_1     = "#404455",
                    -- telescope active line, statusline
                    mono_2     = "#101420",
                    -- statusline text, line numbers, borders
                    mono_3     = "#808495",
                    -- unknown
                    mono_4     = "#606064",
                    -- comments
                    mono_5     = "#8589A0",
                    -- normal text
                    mono_6     = "#d5ced9",
                }
            })
            -- visual highlight
            -- vim.cmd[[highlight Visual guibg=#303445]]
            vim.cmd[[highlight Visual guibg=#454960]]
            -- 80 char line
            vim.cmd[[highlight ColorColumn guibg=#303445]]
            vim.cmd[[highlight ColorColumn guibg=#454960]]
            -- status line inactive (when telescope is active)
            -- vim.cmd[[highlight StatusLineNC guibg=#303445]]
            vim.cmd[[highlight StatusLineNC guibg=#151925]]
            -- float window
            vim.cmd[[highlight NormalFloat guibg=#4f525d]]
        end
    },

}
