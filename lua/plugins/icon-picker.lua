---@type LazySpec
return {
  {
    "ziontee113/icon-picker.nvim",
    opts = {},
    keys = {
      { "<leader>ip", "<cmd>IconPickerNormal<CR>", mode = { "n" }, noremap = true, silent = true, desc = "Icon Picker" },
    },
    cmd = "IconPickerNormal",
  },
}
