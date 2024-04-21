-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin
return {

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires special font.
      --  If you already have a Nerd Font, or terminal set up with fallback fonts
      --  you can enable this
      -- { 'nvim-tree/nvim-web-devicons' }
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of help_tags options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        --
        defaults = {
          layout_config = {
            horizontal = {
              preview_width = 0.65,
            },
          },
          mappings = {
            i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          },
        },
        pickers = {
          buffers = {
            show_all_buffers = true,
            -- sort_lastused = true,
            sort_mru = true,
            theme = "dropdown",
            winblend = 10,
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
              n = {
                ["dd"] = "delete_buffer",
              }
            }
          }
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      -- custom keymaps
      -- files
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>fa", function()
        builtin.find_files({
          hidden = true
        })
      end, { desc = "[F]ind [A]ll (including hidden)"})
      vim.keymap.set("n", "<leader>f.", function()
        builtin.find_files({
          cwd = vim.fn.expand("%:p:h")
        })
      end, { desc = "[F]ind in [.] cwd"})
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[F]ind [O]ld files" })

      -- search
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind search by [G]rep" })
      vim.keymap.set("n", "<leader>fh", builtin.search_history, { desc = "[F]ind Search [H]istory" })

      -- neovim
      vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "[F]ind [M]arks" })
      vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "[F]ind [Q]uickfix" })
      vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "[F]ind [J]ump list" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- git
      vim.keymap.set("n", "<leader>gg", builtin.git_status, { desc = "find [G]it [S]tatus" })
      vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "find [G]it [F]iles" })
      vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "Search [G]it [C]ommits for Buffer"})
      vim.keymap.set("n", "<leader>gC", builtin.git_commits, { desc = "Search [G]it [C]ommits"})
      vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Search [G]it [B]ranches"})
      vim.keymap.set("n", "<leader>gs", builtin.git_stash, { desc = "Search [G]it [S]tash list"})

      -- extras
      vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = "[F]ind [C]olorscheme" })

      -- advanced search
      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      -- -- Shortcut for searching your neovim configuration files
      -- vim.keymap.set('n', '<leader>fn', function()
      --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
      -- end, { desc = '[F]ind [N]eovim files' })
    end,
  },

}
