-- VSCode Neovim
local keymap = vim.keymap.set
local opts = {
  noremap = true,
  silent = true,
}

-- next diagnostic
keymap("n", "]f", "<cmd>lua require('vscode').action('editor.action.marker.nextInFiles')<CR>", opts)
keymap("n", "]d", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>", opts)

-- previous diagnostic
keymap("n", "[f", "<cmd>lua require('vscode').action('editor.action.marker.prevInFiles')<CR>", opts)
keymap("n", "[d", "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>", opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

keymap({ "n", "v" }, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>", opts)
keymap({ "n", "v" }, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>", opts)
keymap({ "n", "v" }, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>", opts)
keymap({ "n", "v" }, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>", opts)
keymap({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>", opts)
keymap({ "n", "v" }, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>", opts)
keymap({ "n", "v" }, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap({ "n", "v" }, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>", opts)

keymap({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
keymap({ "n", "v" }, "<leader><leader>", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
keymap({ "n", "v" }, "<leader>fs", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>", opts)

-- toggle sidebar
keymap(
  { "n", "v" },
  "<leader>e",
  "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>",
  opts
)

-- fold current block
keymap({ "n", "v" }, "za", "<cmd>lua require('vscode').action('editor.fold')<CR>", opts)
-- unfold current block
keymap({ "n", "v" }, "zm", "<cmd>lua require('vscode').action('editor.unfold')<CR>", opts)
-- unfold recursively
keymap({ "n", "v" }, "zr", "<cmd>lua require('vscode').action('editor.unfoldRecursively')<CR>", opts)
-- fold all blocks
keymap({ "n", "v" }, "zR", "<cmd>lua require('vscode').action('editor.unfoldAll')<CR>", opts)
-- unfold all blocks
keymap({ "n", "v" }, "zM", "<cmd>lua require('vscode').action('editor.foldAll')<CR>", opts)

-- select next occurrence of current word
keymap({ "x", "i" }, "<C-d>", function()
  require("vscode").with_insert(function()
    require("vscode").action("editor.action.addSelectionToNextFindMatch")
  end)
end, opts)

-- refactor
keymap({ "n", "x" }, "<leader>r", function()
  require("vscode").with_insert(function()
    require("vscode").action("editor.action.refactor")
  end)
end, opts)

-- next tab using ctrl + 0
keymap("n", "<C-m>", "<cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>", opts)

-- previous tab using ctrl + ,
keymap("n", "<C-a>", "<cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>", opts)
