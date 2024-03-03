return {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- NOTE: Plugins can also be configured to run lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  -- { -- Useful plugin to show you pending keybinds.
  --   'folke/which-key.nvim',
  --   event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  --   config = function() -- This is the function that runs, AFTER loading
  --     require('which-key').setup()
  --
  --     -- Document existing key chains
  --     require('which-key').register {
  --       ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  --       ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  --       ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  --       ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  --       ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  --     }
  --   end,
  -- },

  -- { -- Autoformat
  --   'stevearc/conform.nvim',
  --   opts = {
  --     notify_on_error = false,
  --     format_on_save = {
  --       timeout_ms = 500,
  --       lsp_fallback = true,
  --     },
  --     formatters_by_ft = {
  --       lua = { 'stylua' },
  --       -- Conform can also run multiple formatters sequentially
  --       -- python = { "isort", "black" },
  --       --
  --       -- You can use a sub-list to tell conform to run *until* a formatter
  --       -- is found.
  --       -- javascript = { { "prettierd", "prettier" } },
  --     },
  --   },
  -- },


  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("todo-comments").setup({
        -- Show todo comments in the sign column but don"t highlight the text
        highlight = {
          before = "",
          after = ""
        },
      })
      vim.keymap.set("n", "<leader>td", "<Cmd>TodoTelescope<CR>")
    end
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote

      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      statusline.setup()

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we disable the section for
      -- cursor information because line numbers are already enabled
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return ''
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {}
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
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
    }
  },

  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local undotree = require("undotree")
      undotree.setup({
        keymaps = {
          ["j"] = "move_next",
          ["k"] = "move_prev",
          ["h"] = "move2parent",
          ["J"] = "move_change_next",
          ["K"] = "move_change_prev",
          ["<cr>"] = "action_enter",
          ["p"] = "enter_diffbuf",
          ["q"] = "quit",
        },
      })
      vim.keymap.set("n", "<leader>u", "<Cmd>lua require('undotree').toggle()<CR>")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function ()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt" , "vim" },
      })
    end
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html", "javascript", "typescript", "javascriptreact",
      "typescriptreact", "svelte", "vue", "tsx", "jsx", "rescript",
      "xml",
      "php",
      "markdown",
      "astro", "glimmer", "handlebars", "hbs"
    },
    lazy = true,
    config = true,
  },
}

