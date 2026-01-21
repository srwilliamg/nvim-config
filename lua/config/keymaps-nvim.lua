-- VSCode Neovim
local opts = { noremap = true, silent = true }

-- Move between spaces
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

-- fold current block
-- toggle fold
-- vim.keymap.set({ "n", "v" }, "za", vim.cmd.fold, opts)
-- -- -- unfold current block
-- vim.keymap.set({ "n", "v" }, "zm", vim.cmd.unfold, opts)
-- -- -- fold all blocks
-- vim.keymap.set({ "n", "v" }, "zR", vim.cmd.foldopen, opts)
-- -- -- unfold all blocks
-- vim.keymap.set({ "n", "v" }, "zM", vim.cmd.foldclose, opts)

-- Easy find and replace.
vim.keymap.set(
  { "v" },
  "<leader>wre",
  '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>',
  { desc = "Open search and replace for currently selected text" }
)
vim.keymap.set(
  { "n" },
  "<leader>wre",
  ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>",

  { desc = "Open search and replace for word under cursor" }
)

-- Terminal mode escape to normal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Allow exiting insert mode in terminal by hitting <ESC>
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- Feed ESC in terminal mode using <C-\>
vim.keymap.set("t", "<C-c>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-c><C-c>", "<C-c>")
