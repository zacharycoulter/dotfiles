-- set leader to space
vim.g.mapleader = " "

-- copy into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

-- save keys
vim.keymap.set({ "n", "v" }, "<leader>w", ":w<CR>")
vim.keymap.set({ "n", "v" }, "<leader>q", ":q<CR>")
