return {
  {
    "huggingface/llm.nvim",
    opts = {
      backend = "ollama",
      lsp = {
        bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
      },
      enable_suggestions_on_startup = true,
      -- model = "deepseek-coder:6.7b",
      model = "llama3",
      url = "http://localhost:11434/api/generate",
      tokens_to_clear = { "<|endoftext|>" },
      fim = {
        enabled = true,
        prefix = "<fim_prefix>",
        middle = "<fim_middle>",
        suffix = "<fim_suffix>",
      },
      context_window = 8192,
      accept_keymap = "<C-f>",
      dismiss_keymap = "<C-d>",
      tls_skip_verify_insecure = false,
      request_body = {
        options = {
          -- max_new_tokens = 60,
          temperature = 0.2,
          top_p = 0.95,
        },
      },
    },
  },
}
