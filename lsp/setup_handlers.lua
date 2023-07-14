return {
  -- add custom handler
  rust_analyzer = function(_, opts)
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
    }
  end,

  efm = function()
    local efmls = require "efmls-configs"

    local prettierd = require "efmls-configs.formatters.prettier_d"

    local lua = {
      formatter = require "efmls-configs.formatters.stylua",
    }
    local javascript = {
      formatter = prettierd,
    }

    efmls.init {
      -- on_attach = require("astronvim.utils.lsp").config("efm").on_attach,
      init_options = {
        documentFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
      },
      settings = {
        rootMarkers = { ".git/" },
        languages = {
          lua = {},
        },
      },
    }

    efmls.setup {
      lua = lua,
      javascript = javascript,
      typescript = javascript,
      json = javascript,
      html = javascript,
      css = javascript,
      scss = javascript,
      vue = javascript,
      yaml = javascript,
    }
  end,
}
