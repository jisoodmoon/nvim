return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          -- Not a fan of the default frappe background color
          -- however the rest of the theming is nice.
          frappe = {
            base = "#363636",
            mantle = "#404040",
            crust = "#4d4d4d",
          },
        },
      })
    end,
  },
  { 
    "rose-pine/neovim", 
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "moon",
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },

  -- Git Blame
  { "f-person/git-blame.nvim" },

  -- HTML auto-close / auto-rename
  { "windwp/nvim-ts-autotag" },

  -- Git
  { "tpope/vim-fugitive" },

  -- Glance at LSP definitons
  { "dnlhc/glance.nvim" },

  { "sindrets/diffview.nvim" },

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup({
        handle = {
          blend = 75,
          color = "#f9fcfb",
        },
        marks = {
          Cursor = {
            text = "★",
          },
        },
      })
    end,
  },

  -- Markdown Previews
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },

  -- strictly for fun :)
  { "HiPhish/rainbow-delimiters.nvim" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader><space>f",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find File",
      },
      {
        "<leader><space>g",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader><space>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Telescope buffers",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            preview_cutoff = 0,
          },
        },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          -- This allows ctrl+d to delete buffers from the buffer 
          -- selector in Telescope.
          i = {
            ["<c-d>"] = require('telescope.actions').delete_buffer
          }
        },
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    opts = function()
      local logo = [[
           _____                        
          /     \   ____   ____   ____  
         /  \ /  \ /  _ \ /  _ \ /    \ 
        /    Y    (  <_> |  <_> )   |  \
        \____|__  /\____/ \____/|___|  /
                \/                   \/ 
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
            { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
            { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },

  --[[
  -- Any disabled plugins go here 
  -- List of disabled plugins:
  -- - nvim-notify
  --]]
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}
