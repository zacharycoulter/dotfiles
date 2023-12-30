return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		null_ls.setup({
			sources = {
				formatting.stylua,
				formatting.prettier,
				diagnostics.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file(".eslintrc.js")
							or utils.root_has_file(".eslintrc.cjs")
							or utils.root_has_file(".eslintrc.ts")
							or utils.root_has_file(".eslintrc.json")
							or utils.root_has_file(".eslintrc")
							or utils.root_has_file(".eslintrc.yml")
					end,
				}),
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
