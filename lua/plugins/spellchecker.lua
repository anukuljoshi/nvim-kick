return {
    {
        "kamykn/spelunker.vim",
        config = function ()
            -- Enable spelunker.vim. (default: 1)
            -- 1: enable
            -- 0: disable
            -- let g:enable_spelunker_vim = 1

            -- [[ helper function to toggle spelunker ]]
            function ToggleSpellChecker()
                if vim.g.enable_spelunker_vim == 1 then
                    vim.g.enable_spelunker_vim = 0
                else
                    vim.g.enable_spelunker_vim = 1
                end
            end
            vim.keymap.set("n", "<leader>sc", [[:lua ToggleSpellChecker()<CR>]], { noremap = true, silent = true })

            -- Spellcheck type: (default: 1)
            -- 1: File is checked for spelling mistakes when opening and saving. This
            -- may take a bit of time on large files.
            -- 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
            -- depends on the setting of CursorHold `set updatetime=1000`.
            vim.g.spelunker_check_type = 2
            vim.o.updatetime = 1000

            -- Highlight type: (default: 1)
            -- 1: Highlight all types (SpellBad, SpellCap, SpellRare, SpellLocal).
            -- 2: Highlight only SpellBad.
            -- FYI: https://vim-jp.org/vimdoc-en/spell.html#spell-quickstart
            vim.g.spelunker_highlight_type = 2

            vim.g.spelunker_disable_acronym_checking = 0
            -- Override highlight setting.
            vim.cmd[[
              highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#ff0000
              highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE
            ]]
        end
    },
}
