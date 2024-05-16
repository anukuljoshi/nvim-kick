return {

    {
        -- git
        "lewis6991/gitsigns.nvim",
        opts = {},
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    -- "eol" | "overlay" | "right_align"
                    virt_text_pos = "eol",
                    delay = 500,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    -- Navigation
                    vim.keymap.set("n", "]c", function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end, { expr = true })

                    vim.keymap.set("n", "[c", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    vim.keymap.set('n', '<leader>ha', gs.stage_hunk)
                    vim.keymap.set('n', '<leader>hA', gs.stage_buffer)
                    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk)
                    vim.keymap.set('n', '<leader>hr', gs.reset_hunk)
                    vim.keymap.set('n', '<leader>hR', gs.reset_buffer)
                    vim.keymap.set("n", "<leader>hp", "<Cmd>Gitsigns preview_hunk_inline<CR>", {})
                    vim.keymap.set("n", "<leader>hb", gs.toggle_current_line_blame, {})
                    vim.keymap.set('n', '<leader>hB', function() gs.blame_line{full=true} end)
                    vim.keymap.set('n', '<leader>hd', gs.diffthis)
                end
            })
        end
    },

    {
        "tpope/vim-fugitive",
        config = function ()
            vim.keymap.set("n", "<leader>gv", "<Cmd>:vertical Git<CR>")
            vim.keymap.set("n", "<leader>gh", "<Cmd>:Git<CR>")
        end
    },

    {
        'akinsho/git-conflict.nvim',
        version = "*",
        config = true
    },
}
