-- VSCode Neovim
local keymap = vim.keymap.set
local opts = {
    noremap = true,
    silent = true
}

-- next diagnostic
keymap("n", "]f", "<cmd>lua require('vscode').action('editor.action.marker.nextInFiles')<CR>", opts)
keymap("n", "]d", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>", opts)

-- previous diagnostic
keymap("n", "[f", "<cmd>lua require('vscode').action('editor.action.marker.prevInFiles')<CR>", opts)
keymap("n", "[d", "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>", opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)
  
keymap({"n", "v"}, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>", opts)
keymap({"n", "v"}, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>", opts)
keymap({"n", "v"}, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>", opts)
keymap({"n", "v"}, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>", opts)
keymap({"n", "v"}, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>", opts)
keymap({"n", "v"}, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>", opts)
keymap({"n", "v"}, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>", opts)
keymap({"n", "v"}, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap({"n", "v"}, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>", opts)

keymap({"n", "v"}, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
keymap({"n", "v"}, "<leader><leader>", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
keymap({"n", "v"}, "<leader>fs", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>", opts) 
-- switch to editor
keymap({"n", "v"}, "<leader>e", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>", opts)


-- select next occurrence of current word
keymap({ "x", "i"}, "<C-d>", function()
    require("vscode").with_insert(function()
        require("vscode").action("editor.action.addSelectionToNextFindMatch")
    end)
end, opts)

-- refactor
keymap({"n", "x"}, "<leader>r", function()
    require("vscode").with_insert(function()
        require("vscode").action("editor.action.refactor")
    end)
end, opts)
