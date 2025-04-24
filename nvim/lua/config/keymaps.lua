-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", ";", ":")
map("n", "<leader>,", "<cmd>noh<cr>", { desc = "Clear highlight" })
map({ "n", "v" }, "<Tab>", "%")
map("n", "<C-f>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
