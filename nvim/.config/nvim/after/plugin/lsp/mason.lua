local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local null_ls = require("null-ls")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)                              -- got to declaration
    vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)                  -- show references
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)                 -- see definition and make edits in window
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)             -- go to implementation
    vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)            -- go to type definition
    vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)      -- see available code actions
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)                           -- smart rename
    vim.keymap.set("n", "<leader>D", "<cmd>Telescope lsp_document_diagnostics<CR>", opts) -- see document diagnostics
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)                     -- see workspace diagnostics
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)                             -- go to previous diagnostic
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)                             -- go to next diagnostic
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)                                     -- show hover info
    vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)                            -- restart lsp server

    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.go" },
        callback = function()
            local clients = vim.lsp.buf_get_clients()
            for _, client in pairs(clients) do
                local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
                params.context = { only = { "source.organizeImports" } }

                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
                for _, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
                        else
                            vim.lsp.buf.execute_command(r.command)
                        end
                    end
                end
            end
        end,
    })
end

local capabilities = cmp_nvim_lsp.default_capabilities()

-- enable mason
mason.setup()

mason_lspconfig.setup({
    -- list of servers for mason to install
    ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "svelte",
        "tailwindcss",
        "lua_ls",
    },
    -- auto-install configured servers (with lspconfig)
    automatic_installation = true, -- not the same as ensure_installed
    mason_lspconfig.setup_handlers({
        function(server_name)
            local setup = {
                on_attach = on_attach,
                capabilities = capabilities,
            }
            require("lspconfig")[server_name].setup(setup)
        end,
    }), -- install servers with lspconfig
})

null_ls.setup({
    -- list of formatters & linters for mason to install
    ensure_installed = {
        "prettier", -- ts/js formatter
        "stylua",   -- lua formatter
        "eslint_d", -- ts/js linter
    },
    -- auto-install configured formatters & linters (with null-ls)
    automatic_installation = true,
})

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
