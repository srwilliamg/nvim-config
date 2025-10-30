local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Paste over selection without yanking replaced text
keymap("v", "p", '"_dP', opts)

-- Normal mode remove copy from X and V
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)
keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)

-- remove space default
keymap("n", "<Space>", "", opts)

-- yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', opts)

-- paste from system clipboard
keymap({ "n", "v" }, "<leader>p", '"+p', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- LSP-friendly mappings (require LSP configured)
keymap("n", "gD", vim.lsp.buf.definition, opts)
keymap("n", "gd", vim.lsp.buf.declaration, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "gt", vim.lsp.buf.type_definition, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, opts)

-- Move visual mode
-- keymap("v", "J", ":m '>+1<CR>gv=gv")
-- keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Terminal mode escape to normal mode
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
