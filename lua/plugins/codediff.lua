---@type LazySpec
return {
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    opts = {
      keymaps = {
        view = {
          quit = "q",                    -- Close diff tab
          toggle_explorer = "<leader>b",  -- Toggle explorer visibility (explorer mode only)
          next_hunk = "]c",   -- Jump to next change
          prev_hunk = "[c",   -- Jump to previous change
          next_file = "]f",   -- Next file in explorer mode
          prev_file = "[f",   -- Previous file in explorer mode
          diff_get = "do",    -- Get change from other buffer (like vimdiff)
          diff_put = "dp",    -- Put change to other buffer (like vimdiff)
        },
        explorer = {
          select = "<CR>",    -- Open diff for selected file
          hover = "K",        -- Show file diff preview
          refresh = "R",      -- Refresh git status
          toggle_view_mode = "i",  -- Toggle between 'list' and 'tree' views
          toggle_stage = "-", -- Stage/unstage selected file
          stage_all = "S",    -- Stage all files
          unstage_all = "U",  -- Unstage all files
          restore = "X",      -- Discard changes (restore file)
        },
        conflict = {
          accept_incoming = "ci",  -- Accept incoming (theirs/left) change
          accept_current = "co",   -- Accept current (ours/right) change
          accept_both = "<CR>",      -- Accept both changes (incoming first)
          discard = "dd",          -- Discard both, keep base
          next_conflict = "n",            -- Jump to next conflict
          prev_conflict = "N",            -- Jump to previous conflict
          diffget_incoming = "2do",        -- Get hunk from incoming (left/theirs) buffer
          diffget_current = "3do",         -- Get hunk from current (right/ours) buffer
        },
      },
    }
  },
}
