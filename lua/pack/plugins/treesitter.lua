vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
}

require('treesitter-context').setup({
  line_numbers = true,
  max_lines = 3,
  min_window_height = 20,
})

local keys = {
  { "H", function() require("treesitter-context").go_to_context() end, desc = "Go to context" },
}

require("which-key").add(keys)

local parsers = {
  "javascript",
  "typescript",
  "vue",
  "scss",
  "php",
  "pug",
  "json",
  "css",
  "tsx",
  "html",
  "python",
  "rust",
  "kdl",
  "bash",
  "dockerfile",
  "yaml",
  "terraform",
  "git_config",
  "ssh_config",
  "http",
  "go",
  "xml",
  "c_sharp",
  "yuck",
  "dot",
  "ini",
  "hyprlang",
  "nu",
  "regex",
  "diff",
  "editorconfig",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "hcl",
  "dtd",
  "ecma",
  "fish",
  "html_tags",
  "jsdoc",
  "jsx",
  "latex",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "query",
  "toml",
  "typst",
  "vim",
  "vimdoc",
  "yang"
}

vim.schedule(function()
  require('nvim-treesitter').install(parsers)
  vim.treesitter.language.register('json', { 'jsonc' })
end)

vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.pack.add {
      "https://github.com/wellle/targets.vim",
      "https://github.com/RRethy/vim-illuminate",
      "https://github.com/mawkler/demicolon.nvim",
      "https://github.com/hiphish/rainbow-delimiters.nvim",
    }

    local rainbow_delimiters = require "rainbow-delimiters"

    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
        vue = "rainbow-blocks",
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterGreen",
        "RainbowDelimiterOrange",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
      -- blacklist = { "c", "cpp" },
    }

    require("demicolon").setup({})

    require('nvim-treesitter-textobjects').setup({
      move = {
        set_jumps = true,
      },
    })
  end,
  once = true,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = parsers,
  callback = function(args)
    vim.treesitter.start()
    vim.bo[args.buf].syntax = 'ON' -- only if additional legacy syntax is needed
  end
})
