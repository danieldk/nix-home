-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

map({ "n" }, "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<leader>ws", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split Window Right", remap = true })
-- unmap("n", "<leader>w|")
-- unmap("n", "<leader>w-")
unmap("n", "<leader>gg")
