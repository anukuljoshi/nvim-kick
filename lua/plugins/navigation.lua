return {
    {
        "chentoast/marks.nvim",
        config = function ()
            require("marks").setup({
                refresh_interval = 250,
            })
            vim.keymap.set("n", "<leader>dm", "<Cmd>delm! | delm A-Z0-9<CR>")
            vim.keymap.set("n", "<leader>df", "<Cmd>delmarks a-z<CR>")
        end
    },
    {
        "smoka7/hop.nvim",
        version = "*",
        opts = {},
        config = function()
            local hop = require("hop")
            hop.setup({})
            vim.keymap.set(
                "", "s",
                function()
                    hop.hint_char1()
                end,
                {}
            )
        end
    },
}
