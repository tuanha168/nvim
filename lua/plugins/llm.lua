return {
  {
    "huggingface/llm.nvim",
    opts = {
      backend = "ollama",
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
