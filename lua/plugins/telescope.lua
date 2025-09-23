return {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local keymap = vim.keymap.set
    -- Telescope mapping
    keymap("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
    keymap("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
    keymap("n", "<leader>fe", "<cmd> Telescope file_browser <CR>")
    keymap("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
    keymap("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
    keymap("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
    keymap("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
    keymap("n", "<leader>fc", "<cmd> Telescope colorschemes <CR>")
  end,
}
