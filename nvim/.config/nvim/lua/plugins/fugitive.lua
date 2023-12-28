return {
	"tpope/vim-fugitive",
    event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		vim.keymap.set("n", "<leader>gc", vim.cmd.GitPush)
	end,
}
