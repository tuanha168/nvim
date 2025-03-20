local M = {}

M.config = function()
  local query = {
    "@parameter.inner",
    "@parameter.outer",
    "@function.inner",
    "@function.outer",
    "@call.inner",
    "@call.outer",
  }

  require("nvim-treesitter.configs").setup {
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          -- ["ac"] = "@class.outer",
          -- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          -- You can also use captures from other query groups like `locals.scm`
          -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["L"] = { query = query },
        },
        swap_previous = {
          ["H"] = { query = query },
        },
      },
    },
  }
end

return M
