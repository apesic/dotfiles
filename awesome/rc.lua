-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")
awful.util.terminal = RC.vars.terminal

-- Error handling
require("main.errors")
require("main.theme")

require("main.signals")

-- Custom Local Library
local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  menu    = require("main.menu"),
  rules   = require("main.rules"),
}

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("bindings.globalbuttons"),
  clientbuttons = require("bindings.clientbuttons"),
  globalkeys    = require("bindings.globalkeys"),
  bindtotags    = require("bindings.bindtotags"),
  clientkeys    = require("bindings.clientkeys")
}

local style = {
  wallpaper = require("style.wallpaper"),
  taglist   = require("style.taglist"),
  tasklist  = require("style.tasklist")
}
require("style.statusbar")

RC.layouts = main.layouts()
RC.tags = main.tags()
RC.mainmenu = awful.menu({ items = main.menu() })
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)
menubar.utils.terminal = RC.vars.terminal

awful.rules.rules = main.rules(
    binding.clientkeys(),
    binding.clientbuttons()
)
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)


-- This is used later as the default terminal and editor to run.
terminal = RC.vars.terminal

-- Default modkey.
modkey = RC.vars.modkey

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = RC.layouts

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

