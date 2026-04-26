vim.pack.add({
  Utils.github("folke/flash.nvim"),
})

require("flash").setup({
  modes = {
    -- search { enabled = true },
    char = {
      jump_labels = false,
    },
  },
})

vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").jump()
end, { desc = "Flash Jump" })
vim.keymap.set({ "n", "x", "o" }, "SS", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })
vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash Jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- keys = {
--   { "S",     mode = { "n", "x", "o" }, function() ( require )("flash").jump() end,              desc = "Flash" },
--   { "SS",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
--   { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
--   { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
--   { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
-- }
