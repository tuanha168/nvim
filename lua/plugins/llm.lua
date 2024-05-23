return {
  {
    "huggingface/llm.nvim",
    opts = {
      backend = "ollama",
      lsp = {
        bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
      },
      enable_suggestions_on_startup = true,
      -- model = "codellama:7b",
      -- url = "http://localhost:11434/api/generate",
      -- -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
      -- request_body = {
      --   -- Modelfile options for the model you use
      --   options = {
      --     temperature = 0.2,
      --     top_p = 0.95,
      --   },
      -- },
    },
  },
}
