return {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
        local theme = require("plugins.alpha-themes.main")
        require("alpha").setup(theme.opts)

        vim.keymap.set("n", "<leader>al", ":Alpha<CR>", {})
    end,
}
