---@type LazySpec
return {
  {
    'huggingface/llm.nvim',
    opts = {
      model = "codellama:7b",
      backend = "huggingface",        -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
      url = "http://localhost:11434", -- llm-ls uses "/api/generate"
      request_body = {
        -- Modelfile options for the model you use
        options = {
          temperature = 0.2,
          top_p = 0.95,
        }
      }
    }
  },
}
