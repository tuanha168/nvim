---@type LazySpec
return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup {}
    end,
    keys = {
      {
        "<Leader>ff",
        function() require("fzf-lua").files() end,
        desc = "Find files",
      },
      {
        "<Leader>fo",
        function() require("fzf-lua").oldfiles() end,
        desc = "Find files",
      },
      {
        "<Leader>fw",
        function() require("fzf-lua").live_grep_native() end,
        desc = "Find files",
      },
      {
        "<Leader>fs",
        mode = { "n", "v" },
        function() Chiruno.func.operatorfunc_lua "live_grep_motion" end,
        desc = "Find files",
      },
      {
        "<Leader>f<CR>",
        function() require("fzf-lua").resume() end,
        desc = "Find files",
      },
      {
        "<Leader>o",
        function() require("fzf-lua").lsp_document_symbols() end,
        desc = "Search symbols",
      },
      {
        "gd",
        function() require("fzf-lua").lsp_definitions() end,
        desc = "Search symbols",
      },
      {
        "gr",
        function() require("fzf-lua").lsp_references() end,
        desc = "Search symbols",
      },
      {
        "gy",
        function() require("fzf-lua").lsp_typedefs() end,
        desc = "Search symbols",
      },
      {
        "<Leader>ee",
        function() require("fzf-lua").lsp_code_actions() end,
        desc = "LSP code action",
      },
    },
  },
}
