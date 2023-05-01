return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    enabled = false,
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-f>",
          next = "<C-j>",
          prev = "<C-k>",
        },
      },
    },
  },
}
