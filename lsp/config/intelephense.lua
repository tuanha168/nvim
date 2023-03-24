return {
  on_attach = function(client)
    if vim.fn.has "nvim-0.7" then
      -- nightly
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    else
      -- stable
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end,
  settings = {
    intelephense = {
      diagnostics = {
        undefinedTypes = false,
        -- undefinedFunctions = false,
        -- undefinedConstants = false,
        -- undefinedClassConstants = false,
        -- undefinedMethods = false,
        -- undefinedProperties = false,
        -- undefinedVariables = false,
      },
      environment = {
        includePaths = { "./fuel/core", "./fuel/vendor" },
      },
    },
  },
}
