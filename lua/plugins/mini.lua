return {

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- Simple and easy statusline.
      local statusline = require('mini.statusline')
      statusline.setup()

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we disable the section for
      -- cursor information because line numbers are already enabled
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return ''
      end
    end,
  },

}
