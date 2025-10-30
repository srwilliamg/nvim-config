-- VSCode Neovim
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Move between spaces
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- next diagnostic
keymap("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)

-- previous diagnostic
keymap("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)

-- resize
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- terminal resize
keymap("t", "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap("t", "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap("t", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("t", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Easy find and replace.
vim.keymap.set(
  { "v" },
  "<leader>re",
  '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>',
  { desc = "Open search and replace for currently selected text" }
)
vim.keymap.set(
  { "n" },
  "<leader>re",
  ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>",

  { desc = "Open search and replace for word under cursor" }
)
