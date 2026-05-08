vim.pack.add({
  Utils.github("shortcuts/no-neck-pain.nvim"),
})

require("no-neck-pain").setup({
  width = 160,
  minSideBufferWidth = 0,
  autocmds = {
    enableOnVimEnter = true,
    enableOnTabEnter = true,
    reloadOnColorSchemeChange = false,
    skipEnteringNoNeckPainBuffer = true,
  },
  buffers = {
    left = {
      enabled = true,
    },
    right = {
      enabled = false,
    },
    bo = {
      filetype = "md",
    },
  },
  integrations = {
    NvimTree = {
      position = "left",
      reopen = true,
    },
    neotest = {
      position = "right",
      reopen = true,
    },
    NeoTree = {
      position = "left",
      reopen = false,
    },
    dashboard = {
      enabled = true,
      filetypes = nil,
    },
  },
})
