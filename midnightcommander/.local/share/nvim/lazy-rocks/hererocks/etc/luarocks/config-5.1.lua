-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks" };
}
variables = {
   LUA_DIR = "/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks";
   LUA_BINDIR = "/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin";
   LUA_VERSION = "5.1";
   LUA = "/Users/zacharycoulter/.local/share/nvim/lazy-rocks/hererocks/bin/lua";
}
