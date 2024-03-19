return {

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote

      require('mini.ai').setup { n_lines = 500 }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require('mini.statusline')
      statusline.setup()

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we disable the section for
      -- cursor information because line numbers are already enabled
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return ''
      end

      require("mini.files").setup({
        -- Module mappings created only inside explorer.
        -- Use `''` (empty string) to not create one.
        mappings = {
          close       = '<leader>e',
          go_in       = 'l',
          go_in_plus  = '<CR>',
          go_out      = 'h',
          go_out_plus = 'H',
          reset       = '<BS>',
          reveal_cwd  = '@',
          show_help   = 'g?',
          synchronize = '=',
          trim_left   = '<',
          trim_right  = '>',
        },
      })

      local miniOpenCurrent = function()
        local name = vim.api.nvim_buf_get_name(0)
        MiniFiles.open(name)

        if name ~= '' then
          local depth = -2
          local _, init = name:find(vim.pesc(vim.loop.cwd()))
          while init do
            depth = depth + 1
            init = name:find('/', init + 1)
          end

          for _ = 1, depth do MiniFiles.go_out() end
          for _ = 1, depth do MiniFiles.go_in() end
        end
      end
      vim.keymap.set("n", "<leader>e", miniOpenCurrent, { desc = "open file explorer"})
    end,
  },

}
