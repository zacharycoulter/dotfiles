if functions -q deactivate-lua
    deactivate-lua
end

function deactivate-lua
    if test -x '/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin/lua'
        eval ('/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin/lua' '/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin/get_deactivated_path.lua' --fish)
    end

    functions -e deactivate-lua
end

set -gx PATH '/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin' $PATH
