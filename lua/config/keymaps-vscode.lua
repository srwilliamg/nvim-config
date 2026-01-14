local desc = Utils.plugin_keymap_desc("vscode")
-- VSCode Neovim
local opts = {
  noremap = true,
  silent = true,
}

-- next diagnostic
vim.keymap.set("n", "]f", "<cmd>lua require('vscode').action('editor.action.marker.nextInFiles')<CR>", opts)
vim.keymap.set("n", "]d", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>", opts)

-- previous diagnostic
vim.keymap.set("n", "[f", "<cmd>lua require('vscode').action('editor.action.marker.prevInFiles')<CR>", opts)
vim.keymap.set("n", "[d", "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>", opts)

-- removes highlighting after escaping vim search
vim.keymap.set("n", "<Esc>", "<Esc>:noh<CR>", opts)

vim.keymap.set(
  { "n", "v" },
  "<leader>db",
  "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>",
  opts
)
vim.keymap.set({ "n", "v" }, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>", opts)
vim.keymap.set(
  { "n", "v" },
  "<leader>sp",
  "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>",
  opts
)
vim.keymap.set({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>", opts)
vim.keymap.set(
  { "n", "v" },
  "<leader>cp",
  "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>",
  opts
)
vim.keymap.set({ "n", "v" }, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
vim.keymap.set(
  { "n", "v" },
  "<leader>fd",
  "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>",
  opts
)

vim.keymap.set({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
vim.keymap.set(
  { "n", "v" },
  "<leader><leader>",
  "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>",
  opts
)
vim.keymap.set(
  { "n", "v" },
  "<leader>fs",
  "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>",
  opts
)

-- toggle sidebar
vim.keymap.set(
  { "n", "v" },
  "<leader>e",
  "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>",
  opts
)

-- fold current block
vim.keymap.set({ "n", "v" }, "za", "<cmd>lua require('vscode').action('editor.fold')<CR>", opts)
-- unfold current block
vim.keymap.set({ "n", "v" }, "zm", "<cmd>lua require('vscode').action('editor.unfold')<CR>", opts)
-- unfold recursively
vim.keymap.set({ "n", "v" }, "zr", "<cmd>lua require('vscode').action('editor.unfoldRecursively')<CR>", opts)
-- fold all blocks
vim.keymap.set({ "n", "v" }, "zR", "<cmd>lua require('vscode').action('editor.unfoldAll')<CR>", opts)
-- unfold all blocks
vim.keymap.set({ "n", "v" }, "zM", "<cmd>lua require('vscode').action('editor.foldAll')<CR>", opts)

-- select next occurrence of current word
vim.keymap.set({ "x", "i" }, "<C-d>", function()
  require("vscode").with_insert(function()
    require("vscode").action("editor.action.addSelectionToNextFindMatch")
  end)
end, opts)

-- refactor
vim.keymap.set({ "n", "x" }, "<leader>r", function()
  require("vscode").with_insert(function()
    require("vscode").action("editor.action.refactor")
  end)
end, opts)

-- next tab using ctrl + 0
vim.keymap.set("n", "gn", "<cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>", opts)

-- previous tab using ctrl + ,
vim.keymap.set("n", "ga", "<cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>", opts)

-- LSP-friendly mappings (require LSP configured)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = desc("Go to implementation") })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = desc("Type definition") })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = desc("Definition") })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = desc("Declaration") })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = desc("References") })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = desc("Hover") })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = desc("Rename") })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = desc("Code Action") })
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, { desc = desc("Run Codelens") })
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = desc("Refresh & Display Codelens") })
