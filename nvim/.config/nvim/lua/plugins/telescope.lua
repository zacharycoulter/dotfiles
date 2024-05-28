return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    branch = "0.1.x",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-telescope/telescope-fzy-native.nvim",
            build = "make",
        },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    ".git/",
                    ".cache",
                    "%.pdf",
                    "%.mkv",
                    "%.mp4",
                    "%.zip",
                    "node_modules/",
                    "%_templ.go",
                    ".DS_Store",
                    ".git/",
                    ".tmp/",
                    ".task/",
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                oldfiles = {
                    only_cwd = true,
                },
            },
            extensions = {
                file_browser = {
                    previewer = false,
                    cwd = "%:p:h",
                    initial_mode = "insert",
                    select_buffer = true,
                    hijack_netrw = true,
                    hidden = true,
                    git_status = true,
                    color_devicons = true,
                },
            },
        })
        telescope.load_extension("fzy_native")
        telescope.load_extension("file_browser")
        telescope.load_extension("ui-select")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
        vim.keymap.set("n", "<leader>fb", telescope.extensions.file_browser.file_browser, { noremap = true })
    end,
}
