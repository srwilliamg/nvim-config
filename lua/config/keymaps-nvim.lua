-- Neovim
local opts = { noremap = true, silent = true }

-- Move between splits
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- next diagnostic
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)

-- previous diagnostic
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)

-- next error
vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
end)

-- previous error
vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
end)

-- resize
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- terminal resize
vim.keymap.set("t", "<C-Up>", "<cmd>resize -2<CR>", opts)
vim.keymap.set("t", "<C-Down>", "<cmd>resize +2<CR>", opts)
vim.keymap.set("t", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
vim.keymap.set("t", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Terminal mode escape to normal mode
-- Allow exiting insert mode in terminal by hitting <ESC>
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Feed ESC in terminal mode using <C-\>
vim.keymap.set("t", "<C-c>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-c><C-c>", "<C-c>")
