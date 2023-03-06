local M = {
  matchup = {
    enable = true,
  },
  ensure_installed = {
    "lua",
    "javascript",
    "typescript",
    "vue",
    "scss",
    "regex",
    "php",
    "pug",
    "json",
    "css",
    "tsx",
    "html",
    "python",
    "markdown",
    "markdown_inline",
    "query",
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  -- List of parsers to ignore installing (for "all")
  ignore_install = {},
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "html" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "<CR>",
  --     node_incremental = "<CR>",
  --     scope_incremental = "<Tab>",
  --     node_decremental = "<S-Tab>",
  --   },
  -- },
}

return M
