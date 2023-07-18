return function()
  local ok, efmls = pcall(require, "efmls-configs")
  if not ok then return end

  local lua = {
    formatter = require "efmls-configs.formatters.stylua",
  }
  local prettierd = {
    formatter = require "efmls-configs.formatters.prettier_d",
  }

  efmls.init {
    on_attach = require("astronvim.utils.lsp").config("efm").on_attach,
    init_options = {
      documentFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true,
    },
    settings = {
      rootMarkers = { ".git/" },
      languages = {},
    },
  }

  efmls.setup {
    lua = lua,
    javascript = prettierd,
    typescript = prettierd,
    json = prettierd,
    html = prettierd,
    css = prettierd,
    scss = prettierd,
    vue = prettierd,
    yaml = prettierd,
    php = {
      formatter = require "user.lsp.handlers.efm.pint",
    },
  }
end
