return {
  n = {
    ["<leader>ld"] = false,
    ["<leader>li"] = false,
    ["<leader>lI"] = false,
    ["<leader>lf"] = false,
    ["<leader>la"] = false,
    ["<leader>ll"] = false,
    ["<leader>lL"] = false,
    ["<leader>lr"] = false,
    ["<leader>lR"] = false,
    ["<leader>lh"] = false,
    ["<leader>lG"] = false,
    ["<leader>lD"] = false,
    ["<leader>lS"] = false,
    ["K"] = false,
    ["gT"] = false,
    ["<leader>l"] = {
      function() vim.diagnostic.open_float() end,
      desc = "Hover diagnostics",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format {
          -- control auto formatting on save
          format_on_save = {
            enabled = false,        -- enable or disable format on save globally
            allow_filetypes = {     -- enable format on save for specified filetypes only
              -- "go",
            },
            ignore_filetypes = {     -- disable format on save for specified filetypes
              -- "python",
            },
          },
          disabled = {     -- disable formatting capabilities for the listed language servers
            -- "sumneko_lua",
          },
          timeout_ms = 1000,     -- default format timeout
          -- filter = function(client) -- fully override the default formatting function
          --   return true
          -- end
        }
      end,
    },
    ["<leader>e"] = {
      function() vim.lsp.buf.code_action() end,
      desc = "LSP code action",
    },
    ["<leader>K"] = {
      function() vim.lsp.buf.signature_help() end,
      desc = "Signature help",
    },
    ["<leader>k"] = {
      function() vim.lsp.buf.hover() end,
      desc = "Hover symbol details",
    },
    ["gl"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
    ["gt"] = {
      function() require("telescope.builtin").lsp_type_definitions() end,
      desc = "Definition of current type",
    },
    ["gR"] = {
      function() vim.lsp.buf.rename() end,
      desc = "Rename current symbol",
    },
  },
  v = {
    ["<leader>lf"] = false,
    ["<leader>la"] = false,
  },
}
