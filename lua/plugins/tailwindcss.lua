return {
  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<leader>K", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
    },
    opts = {
      border = "rounded", -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
      focus_preview = false, -- Sets the preview as the current window
    },
  },
}
