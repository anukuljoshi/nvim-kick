return {

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function ()
            require("toggleterm").setup({
                open_mapping = [[<C-p>]],
                hide_numbers = false,
                start_in_insert = true,
                insert_mappings = false,
                terminal_mappings = true,
                direction = "float",
                float_opts = {
                    -- The border key is *almost* the same as "nvim_open_win"
                    -- see :h nvim_open_win for details on borders however
                    -- the "curved" border is a custom border type
                    -- not natively supported but implemented in this plugin.
                    border = "single"
                },
            })
            -- open terminal
            vim.api.nvim_set_keymap(
                "n",
                "<leader>th",
                "<cmd>ToggleTerm direction=horizontal<CR>",
                {noremap = true, silent = true}
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>tv",
                "<cmd>ToggleTerm size=60 direction=vertical<CR>",
                {noremap = true, silent = true}
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>tf",
                "<cmd>ToggleTerm direction=float<CR>",
                {noremap = true, silent = true}
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>tb",
                "<cmd>ToggleTerm direction=tab<CR>",
                {noremap = true, silent = true}
            )
        end
    },

}
