return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({
            -- Global window styling
            winopts = {
                height   = 0.85,
                width    = 0.80,
                row      = 0.35,
                col      = 0.50,
                border   = "rounded",
                backdrop = 60,
                preview  = {
                    border       = "rounded",
                    wrap         = false,
                    hidden       = false,
                    vertical     = "down:45%",
                    horizontal   = "right:60%",
                    layout       = "flex",
                    flip_columns = 100,
                    title        = true,
                    title_pos    = "center",
                    scrollbar    = "float",
                    scrolloff    = -1,
                    delay        = 20,
                    winopts      = {
                        number         = true,
                        relativenumber = false,
                        cursorline     = true,
                        cursorlineopt  = "both",
                        cursorcolumn   = false,
                        signcolumn     = "no",
                        list           = false,
                        foldenable     = false,
                        foldmethod     = "manual",
                    },
                },
            },
            files = {
                previewer = false
            },
            oldfiles = {
                previewer = false,
                cwd_only = true,
            },
            grep = {
                prompt    = "Rg> ",
                previewer = "bat",
                rg_opts   = "--hidden --color=auto --line-number --column --smart-case",
            },
        })

        vim.keymap.set("n", "<leader>fo", function() fzf.oldfiles() end)
        vim.keymap.set("n", "<leader>ff", function() fzf.files() end)
        vim.keymap.set("n", "<leader>fg", function() fzf.live_grep() end)
        vim.keymap.set("n", "<leader>fl", function() fzf.grep_last() end)
        vim.keymap.set("n", "<leader>fh", function() fzf.helptags() end)

        vim.keymap.set("n", "<leader>gd", function() fzf.lsp_definitions() end)
        vim.keymap.set("n", "<leader>gc", function() fzf.lsp_declarations() end)
        vim.keymap.set("n", "<leader>gr", function() fzf.lsp_references() end)
        vim.keymap.set("n", "<leader>gt", function() fzf.lsp_typedefs() end)
        vim.keymap.set("n", "<leader>gi", function() fzf.lsp_implementations() end)
        vim.keymap.set("n", "<leader>gs", function() fzf.lsp_document_symbols() end)
        vim.keymap.set("n", "<leader>gw", function() fzf.lsp_workspace_symbols() end)

        vim.keymap.set("n", "<leader>ca", function() fzf.lsp_code_actions() end)

        vim.keymap.set("n", "<leader>dd", function() fzf.diagnostics_document() end)
        vim.keymap.set("n", "<leader>dw", function() fzf.diagnostics_workspace() end)
    end
}
