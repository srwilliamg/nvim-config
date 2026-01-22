local desc = Utils.plugin_keymap_desc("Neotree")
return {
  {
    enabled = false,
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      {
        mode = { "n" },
        "<leader>e",
        function()
          vim.cmd("Neotree toggle")
        end,
        desc = desc("File Explorer"),
      },
      {
        mode = { "n" },
        "<leader>bl",
        "<cmd>Neotree buffers<CR>",
        desc = desc("Buffers"),
      },
    },
    config = function()
      require("neo-tree").setup({
        enable_git_status = false,
        window = {
          -- width = 30,
          position = "float",
        },
        filesystem = {
          follow_current_file = {
            enabled = true, --This will find and focus the file in the active buffer every time
            -- the current file is changed while the tree is open.
            leave_dirs_open = false, --  false  closes auto expanded dirs, such as with  :Neotree reveal
          },
        },
        buffers = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            -- the current file is changed while the tree is open.
            leave_dirs_open = false, --  false  closes auto expanded dirs, such as with  :Neotree reveal
          },
        },
      })
    end,
  },
}
