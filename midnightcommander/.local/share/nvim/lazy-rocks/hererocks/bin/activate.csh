which deactivate-lua >&/dev/null && deactivate-lua

alias deactivate-lua 'if ( -x '\''/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin/lua'\'' ) then; setenv PATH `'\''/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin/lua'\'' '\''/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin/get_deactivated_path.lua'\''`; rehash; endif; unalias deactivate-lua'

setenv PATH '/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin':"$PATH"
rehash
