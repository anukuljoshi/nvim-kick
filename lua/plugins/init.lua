return {

  -- pretty quickfix list
  {
    "yorickpeterse/nvim-pqf",
    config = function ()
      require("pqf").setup()
    end
  },

  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

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

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {}
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

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

}
