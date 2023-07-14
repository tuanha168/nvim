return{
  filetypes = {
    "lua"
  },
  init_options = {
      documentFormatting = true,
        hover= true,
        documentSymbol= true,
        codeAction= true,
        completion= true
    },
    settings = {
      rootMarkers = {".git/"},
        languages = {
            lua = {
                {formatCommand = "stylua", formatStdin = true}
            }
        }
    }}
