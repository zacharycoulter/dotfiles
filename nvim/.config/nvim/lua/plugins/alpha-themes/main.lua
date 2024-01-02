local icons = require("nvim-web-devicons")

local function button(sc, txt, keybind, opts)
    local sc_ = sc:gsub("%s", "")

    opts = opts
        or {
            shortcut = "[" .. sc .. "]  ",
            cursor = 3,
            align_shortcut = "left",
            hl_shortcut = "Number",
        }
    if keybind then
        local keybind_opts = { noremap = true, silent = true, nowait = true }
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local header = {
    type = "text",
    opts = {
        hl = "AlphaHeader",
    },
    val = {
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    },
}

local recent_files = {
    type = "group",
    val = {
        {
            type = "text",
            val = "Recent Files",
            opts = { hl = "SpecialComment", shrink_margin = false },
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            opts = {
                spacing = 1,
            },
            val = function()
                local function get_extension(fn)
                    local match = fn:match("^.+(%..+)$")

                    local ext = ""
                    if match ~= nil then
                        ext = match:sub(2)
                    end
                    return ext
                end

                local cwd = vim.fn.getcwd()
                local opts = {
                    ignore = function(path, ext)
                        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains({ "gitcommit" }, ext))
                    end,
                    autocd = false,
                }

                local oldfiles = {}
                for _, v in pairs(vim.v.oldfiles) do
                    if #oldfiles == 9 then
                        break
                    end
                    local cwd_cond
                    if not cwd then
                        cwd_cond = true
                    else
                        cwd_cond = vim.startswith(v, cwd)
                    end
                    local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
                    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
                        oldfiles[#oldfiles + 1] = v
                    end
                end

                local buttons = {}
                for i, file in ipairs(oldfiles) do
                    if i > 10 then
                        break
                    end
                    local filename = vim.fn.fnamemodify(file, ":.")
                    if #filename > 75 then
                        local match1, match2 = string.match(filename, "(%w+)/%S+/(%w+%.%w+)")
                        filename = match1 .. "/.../" .. match2
                    end
                    local icon = icons.get_icon(filename, get_extension(filename), { default = true })
                    buttons[i] = button(tostring(i), icon .. "  " .. filename, ":e " .. file .. "<CR>")
                end
                return buttons
            end,
        },
    },
}

local quicklinks = {
    type = "group",
    val = {
        {
            type = "text",
            val = "Quicklinks",
            opts = { hl = "SpecialComment", shrink_margin = false },
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            opts = {
                spacing = 1,
            },
            val = {
                button("e", "  new file", ":ene <CR>"),
                button("f", "  find file", ":Telescope find_files <CR>"),
                button("b", "  file browser", ":Telescope file_browser <CR>"),
                button("t", "  find text", ":Telescope live_grep <CR>"),
                button("g", "  git", ":Git <CR>"),
                button("l", "󰒲  lazy", ":Lazy <CR>"),
            },
        },
    },
}

local quote = {
    type = "text",
    val = require("alpha.fortune")(),
    opts = {
        hl = "Number",
    },
}

local lazy = {
    type = "text",
    val = "",
    opts = {
        hl = "Comment",
    },
}

vim.api.nvim_create_autocmd("User", {
    callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100) / 100
        lazy.val = "󱐌 Lazy-loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
    end,
})

return {
    opts = {
        opts = {
            margin = 5,
        },
        layout = {
            { type = "padding", val = 4 },
            header,
            { type = "padding", val = 3 },
            recent_files,
            { type = "padding", val = 2 },
            quicklinks,
            { type = "padding", val = 2 },
            button("q", "󰅚  quit neovim", ":q<CR>"),
            { type = "padding", val = 4 },
            lazy,
        },
    },
}
