return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "astrodark",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "angularls",
      -- "html",
      "emmet_ls",
      -- "vuels",
      "volar",
      -- "tsserver",
      "eslint",
      "lua_ls",
      "intelephense",
      "cssls",
      "pylsp",
      "jsonls",
    },
    mappings = {
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
        ["<leader>fm"] = { function() vim.lsp.buf.format(M.format_opts) end },
        ["<leader>e"] = {
          function() vim.lsp.buf.code_action() end,
          desc = "LSP code action",
        },
        ["<leader>k"] = {
          function() vim.lsp.buf.signature_help() end,
          desc = "Signature help",
        },
        ["gl"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
        ["gt"] = {
          function() require("telescope.builtin").lsp_type_definitions() end,
          desc = "Definition of current type",
        },
      },
      v = {
        ["<leader>lf"] = false,
        ["<leader>la"] = false,
      },
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin", "matchparen" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    local autocmd = vim.api.nvim_create_autocmd

    autocmd({ "BufEnter" }, {
      pattern = "*",
      callback = function()
        vim.cmd "set laststatus&"
        vim.cmd "syntax sync fromstart"
      end,
    })

    autocmd({ "FocusGained", "BufEnter" }, {
      pattern = "*",
      callback = function() vim.cmd "checktime" end,
    })

    autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.conf",
      callback = function() vim.cmd "setf dosini" end,
    })
  end,
}
