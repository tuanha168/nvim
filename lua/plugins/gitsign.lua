---@type LazySpec
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local conf = require "config.gitsign"
      for k, v in pairs(conf) do
        opts[k] = v
      end
      local default_on_attach = opts.on_attach

      opts.on_attach = function(bufnr)
        default_on_attach(bufnr)
        local haveRepoLink, _ = pcall(require, "repolink")
        if not haveRepoLink then return end

        vim.keymap.set("n", "<Leader>gL", function()
          local prefix = ""
          if vim.api.nvim_get_mode().mode == "V" or vim.api.nvim_get_mode().mode == "v" then prefix = "'<,'>" end
          vim.ui.input({ prompt = "Origin (default: origin): " }, function(origin)
            if origin == nil or origin == "" then origin = "origin" end
            local current_branch = string.sub(vim.fn.system "git branch --show-current", 1, -2)
            vim.ui.input({ prompt = "Branch:", default = current_branch }, function(branch)
              if branch == nil or branch == "" then branch = current_branch end
              Chiruno.func.feedkeys(":" .. prefix .. "RepoLink! " .. branch .. " " .. origin .. "<CR>", "n")
            end)
          end)
        end, { buffer = bufnr })
      end

      return opts
    end,
  },
}
