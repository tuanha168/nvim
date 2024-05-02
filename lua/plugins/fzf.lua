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
        function() require("fzf-lua").grep_cword() end,
        desc = "Find files",
      },
      {
        "<Leader>f<CR>",
        function() require("fzf-lua").resume() end,
        desc = "Find files",
      },
      {
        "<Leader>fs",
        function() require("fzf-lua").grep_visual() end,
        desc = "Find files",
      },
    },
  },
}
