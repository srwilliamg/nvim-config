vim.pack.add({
  Utils.github("folke/trouble.nvim"),
})

require("trouble").setup()

-- Toggle trouble

vim.keymap.set("n", "<leader>xx", function()
  vim.cmd("Trouble diagnostics filter = { severity=vim.diagnostic.severity.ERROR }")
end)

vim.keymap.set("n", "<leader>xt", function()
  require("trouble").toggle()
end)

-- Toggle document diagnostics
vim.keymap.set("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end)
