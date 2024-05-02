---@type LazySpec
return {
  "rbong/vim-flog",
  cmd = { "Flog", "Flogsplit", "Floggit" },
  dependencies = {
    { "tpope/vim-fugitive", cmd = { "Git" } },
  },
}
