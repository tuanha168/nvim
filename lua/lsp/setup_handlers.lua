return {
  function(server) require("lspconfig")[server].setup(require("lsp.config").config(server)) end,
  -- add custom handler
  ["rust_analyzer"] = function(_, opts)
    require("rust-tools").setup {
      tools = {
        reload_workspace_from_cargo_toml = true,
        runnables = {
          use_telescope = true,
        },
        inlay_hints = {
          auto = true,
          only_current_line = false,
          show_parameter_hints = false,
          parameter_hints_prefix = "<-",
          other_hints_prefix = "=>",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
          highlight = "Comment",
        },
        hover_actions = {
          border = "rounded",
        },
        on_initialized = function()
          vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
            pattern = { "*.rs" },
            callback = function()
              local _, _ = pcall(vim.lsp.codelens.refresh)
            end,
          })
        end,
      },
      server = opts,
      dap = {
        adapters = {
          type = "executable",
          command = "lldb-vscode",
          name = "rt_lldb",
        },
      },
    }
  end,
}
