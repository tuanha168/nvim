local lazy = require("pack.lazy-load")

lazy.on_command(
  { "https://github.com/esmuellert/codediff.nvim", "https://github.com/MunifTanjim/nui.nvim" },
  "CodeDiff",
  function()
    require("codediff").setup {
      keymaps = {
        view = {
          quit = "q",
          toggle_explorer = "<leader>b",
          next_hunk = "]g",
          prev_hunk = "[g",
          next_file = "]f",
          prev_file = "[f",
          diff_get = "do",
          diff_put = "dp",
        },
        explorer = {
          select = "<CR>",
          hover = "K",
          refresh = "R",
          toggle_view_mode = "i",
          toggle_stage = "-",
          stage_all = "S",
          unstage_all = "U",
          restore = "X",
        },
        conflict = {
          accept_incoming = "ci",
          accept_current = "co",
          accept_both = "<CR>",
          discard = "dd",
          next_conflict = "n",
          prev_conflict = "N",
          diffget_incoming = "ci",
          diffget_current = "co",
        },
      },
    }
  end
)
