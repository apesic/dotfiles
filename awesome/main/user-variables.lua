local home = os.getenv("HOME")

local _M = {
  -- This is used later as the default terminal and editor to run.
  terminal = "kitty",

  -- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
  modkey = "Mod4",

  -- user defined wallpaper
  --wallpaper = home .. "/Pictures/your-wallpaper-here.jpg",
}

return _M
