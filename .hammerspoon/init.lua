hs.alert.defaultStyle.strokeColor =  {white = 1, alpha = 0}
hs.alert.defaultStyle.fillColor =  {white = 0.05, alpha = 0.75}
hs.alert.defaultStyle.radius =  10

require('caffeine')
--require('vim')
local keybindings = require('keybindings')
local audio = require('hs.audiodevice')

local mash = {"cmd", "alt"}
local mash_app = {"cmd", "ctrl"}

keybindings.newOneTapMetaBinding(keybindings.keys.ctrl, {}, 'escape')

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/dotfiles/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

---- Switch apps
hs.hotkey.bind(mash_app, 'C', function() hs.application.launchOrFocus('Google Chrome') end)
hs.hotkey.bind(mash_app, 'T', function() hs.application.launchOrFocus('/Applications/iTerm.app') end)
hs.hotkey.bind(mash_app, 'V', function() hs.application.launchOrFocus('MacVim') end)
hs.hotkey.bind(mash_app, 'E', function() hs.application.launchOrFocus('/usr/local/Cellar/emacs-plus/25.2/Emacs.app') end)
hs.hotkey.bind(mash_app, 'K', function() hs.application.launchOrFocus('Slack') end)
hs.hotkey.bind(mash_app, 'S', function() hs.application.launchOrFocus('Spotify') end)

hs.window.animationDuration = 0
-- Left half
hs.hotkey.bind(mash, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Right half
hs.hotkey.bind(mash, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Top half
hs.hotkey.bind(mash, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Bottom half
hs.hotkey.bind(mash, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Full Screen
hs.hotkey.bind(mash, "f", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- Window Hints
hs.hotkey.bind({"cmd"},"e", function()
  hs.hints.windowHints()
end)

function moveToScreen(screenPos)
  window = hs.window.focusedWindow()
  screen = hs.screen.find({x=screenPos, y=0})
  window:moveToScreen(screen)
  window:maximize()
end

hs.hotkey.bind(mash, "1", function()
  moveToScreen(-1)
end)

hs.hotkey.bind(mash, "2", function()
  moveToScreen(0)
end)

hs.hotkey.bind(mash, "3", function()
  moveToScreen(1)
end)

-- Layouts --

local laptop = "Color LCD"

local centerScreen = hs.screen{x=0,y=0}
local rightScreen = hs.screen{x=1,y=0}
local leftScreen = hs.screen{x=-1,y=0}

local workLayout = {
  {"Google Chrome", nil, rightScreen, hs.layout.maximized, nil, nil},
  {"MacVim", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Emacs", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"iTerm2", nil, rightScreen, hs.layout.maximized, nil, nil},
  {"Slack", nil, laptop, hs.layout.left50, nil, nil},
  {"Spotify", nil, laptop, hs.layout.right50, nil, nil},
  {"SoundCleod", nil, laptop, hs.layout.right50, nil, nil},
}

local laptopLayout = {
  {"Google Chrome", nil, laptop, hs.layout.maximized, nil, nil},
  {"MacVim", nil, laptop, hs.layout.maximized, nil, nil},
  {"Emacs", nil, laptop, hs.layout.maximized, nil, nil},
  {"iTerm2", nil, laptop, hs.layout.maximized, nil, nil},
  {"Slack", nil, laptop, hs.layout.maximized, nil, nil},
  {"Spotify", nil, laptop, hs.layout.maximized, nil, nil},
  {"SoundCleod", nil, laptop, hs.layout.maximized, nil, nil},
}

local homeLayout = {
  {"Google Chrome", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"MacVim", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Emacs", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"iTerm2", nil, leftScreen, hs.layout.maximized, nil, nil},
  {"Slack", nil, laptop, hs.layout.left50, nil, nil},
  {"Spotify", nil, laptop, hs.layout.right50, nil, nil},
  {"SoundCleod", nil, laptop, hs.layout.right50, nil, nil},
}

hs.hotkey.bind(mash, "r", function()
  switchLayout()
end)

-- Screen watcher
local lastNumberOfScreens = #hs.screen.allScreens()

function switchLayout()
  local numScreens = #hs.screen.allScreens()
  local primaryScreen = hs.screen.allScreens()[1]:name()
  local layout = {}

  if numScreens == 1 then
    layout = laptopLayout
    layoutName = "Laptop layout"
  elseif primaryScreen == "Thunderbolt Display" then
    layout = workLayout
    layoutName = "Thunderbolt layout"
  elseif primaryScreen == dellUS then
    layout = homeLayout
    layoutName = "Home layout"
  end
  hs.layout.apply(layout)
  hs.alert.show(layoutName)
end

function onScreensChanged()
  numScreens = #hs.screen.allScreens()
  if lastNumberOfScreens ~= numScreens then
    switchLayout()
    lastNumberOfScreens = numScreens
  end
end

local screenWatcher = hs.screen.watcher.new(onScreensChanged):start()

---- GTD task taker

-- CP'ed from https://github.com/Hammerspoon/hammerspoon/issues/782
local chooser = nil

local commands = {
  {
    ['text'] = 'Add TODO',
    ['subText'] = 'Prepend to todo.org',
    ['command'] = 'prepend',
  },
}

-- This resets the choices to the command table, and has the side effect
-- of resetting the highlighted choice as well.
local function resetChoices()
  chooser:rows(#commands)
  -- add commands
  local choices = {}
  for _, command in ipairs(commands) do
    choices[#choices+1] = command
  end
  chooser:choices(choices)
end

local function prependCallbackFn (exitCode, stdOut, stdErr)
  if exitCode > 0 then
    print("Prepend failure", exitCode, stdOut, stdErr)
  end
end

local function prepend(text)
  -- sed -i '1i Text to prepend' file.txt
  hs.task.new("/usr/local/bin/gsed",
              appendCallbackFn,
              {"-i", "2i ** TODO " .. text .. "", os.getenv("HOME") .. "/Dropbox (Personal)/notes/todo.org"}
  ):start()
  hs.notify.new({title="Added TODO",informativeText=text}):send()
end

local function choiceCallback(choice)
  if choice.command == 'prepend' then
    prepend(chooser:query())
  else
    print("Unknown choice!")
  end
  -- set the chooser back to the default state
  resetChoices()
  chooser:query('')
end

hs.hotkey.bind(mash_app, "A", function()
  chooser = hs.chooser.new(choiceCallback)
  -- disable built-in search
  chooser:queryChangedCallback(function() end)
  -- populate the command list
  resetChoices()
  chooser:show()
end)

local spotifyBar = hs.menubar.new()
function setSpotifyTitle()
  local title = ""
  if hs.spotify.isRunning() then
    if hs.spotify.isPlaying() then
      symbol = "▶ "
    else
      symbol = "‖ "
    end
    title = symbol .. hs.spotify.getCurrentTrack() .. " – " .. hs.spotify.getCurrentArtist()
  end
  spotifyBar:setTitle(title)
end

-- Using a constantly true doWhile because there's a bug with hs.timer.doEvery that causes it to stop working
-- after about 50 iterations
local spotTimer = hs.timer.doWhile(
  function() return true end,
  function ()
    -- There's a bug in Hammerspoon's Spotify API that occasionally causes it to fail and throw an exception
    local status, err = pcall(setSpotifyTitle)
    if not status then
      print("Caught error: " .. err)
    end
  end
)
