---@type LazySpec
return {
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
  },
  {
    "saecki/crates.nvim",
    lazy = true,
    ft = { "rust", "toml" },
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
      popup = {
        border = "rounded",
      },
    },
  },
}
