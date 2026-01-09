local desc = Utils.plugin_keymap_desc("Neotree")
return {
  {
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
        "<cmd>Neotree toggle<CR>",
        desc = desc("File Explorer"),
      },
    },
  },
}
