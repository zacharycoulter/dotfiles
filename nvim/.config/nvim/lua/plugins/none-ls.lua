return {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        require("mason-null-ls").setup({
            handlers = {},
            ensure_installed = {
                "stylua",
                "beautysh",
                "prettier",
                "gofmt",
                "goimports",
                "templ",
                "hadolint",
                "eslint",
            },
            automatic_installation = true,
        })
        require("null-ls").setup()

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
