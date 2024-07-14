return {

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function ()
            local api = require("nvim-tree.api")

            local function my_on_attach(bufnr)
                local function opts(desc)
                    return {
                        desc = "nvim-tree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true
                    }
                end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                -- h, j, k, l Style Navigation And Editing
                vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Parent"))
                vim.keymap.set("n", "l", api.node.open.edit, opts("Edit"))
                vim.keymap.set("n", "H", api.tree.collapse_all, opts("Close all"))
            end

            -- setup with some options
            require("nvim-tree").setup({
                on_attach = my_on_attach,
                hijack_cursor = true,
                renderer = {
                    group_empty = false,
                },
                view = {
                    side = "right",
                    width = 45,
                },
                actions = {
                    open_file = {
                        quit_on_open = true,
                    },
                },
                live_filter = {
                    prefix = "[FILTER]: ",
                    always_show_folders = false, -- Turn into false from true by default
                }
            })

            -- workaround when using sessions
            vim.api.nvim_create_autocmd({ 'BufEnter' }, {
                pattern = 'NvimTree*',
                callback = function()
                    local view = require('nvim-tree.view')
                    if not view.is_visible() then
                        api.tree.open()
                    end
                end,
            })

            -- focus file with toggle
            local nvimTreeFocusOrToggle = function ()
                local currentBuf = vim.api.nvim_get_current_buf()
                local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
                if currentBufFt == "NvimTree" then
                    vim.cmd("NvimTreeToggle")
                else
                    vim.cmd("NvimTreeFindFile")
                end
            end
            vim.keymap.set("n", "<leader>e", nvimTreeFocusOrToggle)

            -- Go to last used hidden buffer when deleting a buffer
            vim.api.nvim_create_autocmd("BufEnter", {
                nested = true,
                callback = function()
                    -- Only 1 window with nvim-tree left: we probably closed a file buffer
                    if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
                        -- Required to let the close event complete. An error is thrown without this.
                        vim.defer_fn(function()
                            -- close nvim-tree: will go to the last hidden buffer used before closing
                            api.tree.toggle({find_file = true, focus = true})
                            -- re-open nvim-tree
                            -- api.tree.toggle({find_file = true, focus = true})
                            -- nvim-tree is still the active window. Go to the previous window.
                            -- vim.cmd("wincmd p")
                            -- vim.cmd("q")
                        end, 0)
                    end
                end
            })
        end
    },

}
