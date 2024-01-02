return {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    opts = function()
        return {
            default = true,
            override_by_extension = {
                ["toml"] = {
                    icon = "",
                    color = "#81e043",
                    name = "toml",
                },
            },
        }
    end,
}
