return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        event = "VeryLazy",
        config = function()
            local mason_lspconfig = require("mason-lspconfig")
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
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- show code actions
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)     -- restart lsp server
            end

            require("mason").setup()
            mason_lspconfig.setup({
                ensure_installed = { "lua_ls", "tsserver", "gopls", "svelte", "html", "jsonls", "templ" },
            })
            mason_lspconfig.setup_handlers({
                function(server_name)
                    local options = {
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }
                    if server_name == "html" then
                        options.filetypes = { "html", "templ" }
                    end
                    if server_name == "htmx" then
                        options.filetypes = { "html", "templ" }
                    end
                    if server_name == "tailwindcss" then
                        options.filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte", "html" }
                        options.init_options = { userLanguages = { templ = "html" } }
                    end

                    require("lspconfig")[server_name].setup(options)
                end,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*" },
                callback = function()
                    if vim.bo.filetype == "templ" then
                        vim.lsp.buf.format({
                            async = true,
                            name = "templ",
                            filter = function(client)
                                return client.name == "templ"
                            end,
                        })
                        return
                    end
                    vim.lsp.buf.format()
                end,
            })

            vim.filetype.add({ extension = { templ = "templ" } })
        end,
    },
}
