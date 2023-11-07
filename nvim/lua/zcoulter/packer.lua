vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"nvim-telescope/telescope-fzy-native.nvim",
				run = "make",
			},
		},
	})

	-- design
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("nvim-lualine/lualine.nvim")

	-- autocompletion
	use({
		"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
	})

	-- configuring lsp servers
	use({
		"neovim/nvim-lspconfig",
			requires = {
				{
					"williamboman/mason.nvim",
						requires = {
							"williamboman/mason-lspconfig.nvim",
						},
				},
					"jose-elias-alvarez/null-ls.nvim",
				"hrsh7th/cmp-nvim-lsp",
			},
	})

	-- treesitter
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- comment code
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	use("tpope/vim-fugitive")

	-- misc
	use("github/copilot.vim")
end)
