---@type LazySpec
return {
  {
    'huggingface/llm.nvim',
    opts = {
      backend = "ollama",             -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
      model = "codellama:7b",
      url = "http://localhost:11434", -- llm-ls uses "/api/generate"
      -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
      request_body = {
        -- Modelfile options for the model you use
        options = {
          temperature = 0.2,
          top_p = 0.95,
        },
        headers = {

        }
      },
      fim = {
        enabled = true,
        prefix = "<PRE> ",
        middle = " <MID>",
        suffix = " <SUF>",
      },
      debounce_ms = 150,
      accept_keymap = "<C-f>",
      dismiss_keymap = "<ESC>",
      context_window = 1024,             -- max number of tokens for the context window
      enable_suggestions_on_startup = true,
      enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
    },
  },
}
