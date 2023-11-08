local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        file_ignore_patterns = { ".git/", ".cache", "%.pdf", "%.mkv", "%.mp4", "%.zip", "node_modules/" },
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,                       -- move to prev result
                ["<C-j>"] = actions.move_selection_next,                           -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true
        }
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
        },
    },
})

telescope.load_extension("fzy_native")
telescope.load_extension("file_browser")

vim.api.nvim_set_keymap(
    "n",
    "<leader>fb",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true }
)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
