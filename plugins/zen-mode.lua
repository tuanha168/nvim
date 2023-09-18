return {
  {
    "folke/zen-mode.nvim",
    event = "BufEnter",
    opts = function()
      local win
      return {
        window = {
          width = 0.60,
        },
        on_open = function(_win) win = _win end,
        on_close = function()
          if not win then return end
          if vim.api.nvim_win_get_buf(win.parent) ~= vim.api.nvim_win_get_buf(win.win) then
            vim.api.nvim_win_set_buf(win.parent, vim.api.nvim_win_get_buf(win.win))
            vim.api.nvim_win_set_cursor(win.parent, vim.api.nvim_win_get_cursor(win.win))
          end
        end,
      }
    end,
    keys = {
      {
        "<leader>z",
        function()
          -- close NeoTree
          local ok, neo = pcall(require, "neo-tree.command")
          if ok then neo.execute { action = "close" } end

          require("zen-mode").toggle()
        end,
        desc = "Zen Mode",
      },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "try_statement",
      },
    },
  },
}
