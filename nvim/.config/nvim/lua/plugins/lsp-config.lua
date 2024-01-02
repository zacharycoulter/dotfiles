return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
        },
        event = "VeryLazy",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = function(_, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show references
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- see definition and make edits in window
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- go to implementation
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- go to type definition

                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)    -- smart rename
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)      -- go to previous diagnostic
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)      -- go to next diagnostic
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)              -- show hover info
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)     -- restart lsp server
            end
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "tsserver", "gopls", "svelte", "html", "jsonls" },
            })
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } },
                            },
                        },
                    })
                end,
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*" },
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end,
    },
}
