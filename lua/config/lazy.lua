local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Theme
    {
      "sainnhe/gruvbox-material",
      priority = 1000,
      lazy = false,
      config = function()
        vim.cmd.set("termguicolors")
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_foreground = "material"
        vim.g.gruvbox_material_better_performance = 1
        vim.cmd.colorscheme("gruvbox-material")
      end,
    },

    {
      "neovim/nvim-lspconfig",
      opts = {
        inlay_hints = { enabled = false },
      },
    },

    {
      "f-person/git-blame.nvim",
      event = "VeryLazy",
      opts = {
        enabled = true,
        highlight_group = "NonText",
        message_template = "     <author>, <date>, <summary>",
        date_format = "%r",
        delay = 1,
      },
    },

    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        bigfile = { enabled = true },
        dashboard = {
          enabled = true,
          sections = {
            { section = "header" },
            { section = "keys", gap = 0 },
            { icon = "> ", title = "Projects", section = "projects", indent = 2, padding = 4 },
            { section = "startup" },
          },
        },
        git = { enabled = false },
        gitbrowse = { enabled = false },
        indent = { enabled = true },
        input = { enabled = true },
        notify = { enabled = true },
        notifier = {
          enabled = true,
          timeout = 5000,
        },
        picker = {
          sources = {
            explorer = {
              layout = {
                preset = "right",
              },
            },
          },
        },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        scope = { enabled = true },
        styles = {},
      },
      keys = {
        {
          "<leader>.",
          function()
            Snacks.scratch()
          end,
          desc = "Toggle Scratch Buffer",
        },
        {
          "<leader>S",
          function()
            Snacks.scratch.select()
          end,
          desc = "Select Scratch Buffer",
        },
        {
          "<leader>n",
          function()
            Snacks.notifier.show_history()
          end,
          desc = "Notification History",
        },
        {
          "<leader>bd",
          function()
            Snacks.bufdelete()
          end,
          desc = "Delete Buffer",
        },
        {
          "<leader>cR",
          function()
            Snacks.rename.rename_file()
          end,
          desc = "Rename File",
        },
        {
          "<leader>gg",
          function()
            Snacks.lazygit()
          end,
          desc = "Lazygit",
        },
        {
          "<leader>gl",
          function()
            Snacks.lazygit.log()
          end,
          desc = "Lazygit Log (cwd)",
        },
        {
          "<leader>un",
          function()
            Snacks.notifier.hide()
          end,
          desc = "Dismiss All Notifications",
        },
        {
          "<c-/>",
          function()
            Snacks.terminal()
          end,
          desc = "Toggle Terminal",
        },
        {
          "]]",
          function()
            Snacks.words.jump(vim.v.count1)
          end,
          desc = "Next Reference",
          mode = { "n", "t" },
        },
        {
          "[[",
          function()
            Snacks.words.jump(-vim.v.count1)
          end,
          desc = "Prev Reference",
          mode = { "n", "t" },
        },
      },
    },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
      },
    },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
          "go",
          "tsx",
          "typescript",
        })
      end,
    },

    {
      "stevearc/oil.nvim",
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {
        view_options = {
          show_hidden = true,
        },
      },
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
    },

    {
      "folke/trouble.nvim",
      opts = { use_diagnostic_signs = true },
    },

    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {},
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
})

vim.o.cursorline = false
