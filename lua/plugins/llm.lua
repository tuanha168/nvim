return {
  {
    "huggingface/llm.nvim",
    opts = {
      backend = "ollama",
      lsp = {
        bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
      },
      enable_suggestions_on_startup = true,
      model = "llama3",
      url = "http://localhost:11434/api/generate",
      accept_keymap = "<C-f>",
      dismiss_keymap = "<C-d>",
      request_body = {
        parameters = {
          max_new_tokens = 60,
          temperature = 0.2,
          top_p = 0.95,
        },
      },
    },
  },
}
