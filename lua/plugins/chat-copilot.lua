return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {

      model = "gpt-4.1", -- AI model to use
      temperature = 0.8, -- Lower = focused, higher = creative
      -- window = {
      --   layout = "vertical", -- 'vertical', 'horizontal', 'float'
      --   width = 0.5, -- 50% of screen width
      -- },
      auto_insert_mode = true, -- Enter insert mode when opening
      window = {
        layout = "float",
        width = 100, -- Fixed width in columns
        height = 40, -- Fixed height in rows
        border = "rounded", -- 'single', 'double', 'rounded', 'solid'
        title = "🤖 AI Assistant",
        zindex = 100, -- Ensure window stays on top
      },

      headers = {
        user = "👤 You",
        assistant = "🤖 Copilot",
        tool = "🔧 Tool",
      },

      separator = "━━",
      auto_fold = true, -- Automatically folds non-assistant messages
    },
  },
}
