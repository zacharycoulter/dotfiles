return {
    "zeioth/none-ls-autoload.nvim",
    event = "BufEnter",
    dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
    opts = {},
}
-- return {
--     "jay-babu/mason-null-ls.nvim",
--     dependencies = {
--         "williamboman/mason.nvim",
--         "nvimtools/none-ls.nvim",
--     },
--     config = function()
--         require("mason-null-ls").setup({
--             handlers = {},
--             ensure_installed = {
--                 "stylua",
--                 "beautysh",
--                 "prettier",
--                 "gofmt",
--                 "goimports",
--                 "templ",
--                 "hadolint",
--                 "eslint",
--                 "phpactor",
--                 "easy-coding-standard",
--             },
--             automatic_installation = true,
--         })
--         require("null-ls").setup()
--
--         vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
--     end,
-- }
