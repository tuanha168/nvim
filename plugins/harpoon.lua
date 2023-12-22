return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "ma",
        mode = { "n" },
        function() require("harpoon.mark").add_file() end,
        desc = "Add file to harpoon",
      },
      {
        "md",
        mode = { "n" },
        function() require("harpoon.ui").nav_prev() end,
        desc = "Previous mark",
      },
      {
        "mf",
        mode = { "n" },
        function() require("harpoon.ui").nav_next() end,
        desc = "Next mark",
      },
      {
        "ml",
        mode = { "n" },
        function() require("harpoon.ui").toggle_quick_menu() end,
        desc = "List marks",
      },
    },
    config = function()
      require("harpoon").setup {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = false,

        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository
        mark_branch = false,

        -- enable tabline with harpoon marks
        tabline = false,
        tabline_prefix = "   ",
        tabline_suffix = "   ",

        menu = {
          width = 120,
        },
      }
    end,
  },
}