hs.alert.defaultStyle.strokeColor =  {white = 1, alpha = 0}
hs.alert.defaultStyle.fillColor =  {white = 0.05, alpha = 0.75}
hs.alert.defaultStyle.radius =  10

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
hs.pathwatcher.new(os.getenv("HOME") .. "/src/dotfiles/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

require('caffeine')
require('lib')

local keybindings = require('keybindings')
local audio = require('hs.audiodevice')
local spotify = require('hs.spotify')

local mash = {"cmd", "alt"}
local mashShift = {"cmd", "alt", "shift"}
local mashApp = {"cmd", "ctrl"}

-- keybindings.newOneTapMetaBinding(keybindings.keys.ctrl, {}, 'escape')

-- Copied from Philc's config
-- Like hs.application.launchOrFocus, except that it works for apps created using Epichrome.
-- I'm not sure why this implementation has different behavior than hs.application.launchOrFocus.
-- Reference: https://github.com/Hammerspoon/hammerspoon/issues/304
function myLaunchOrFocus(appName)
  local app = hs.appfinder.appFromName(appName)
  if app == nil then
    hs.application.launchOrFocus(appName)
  else
    windows = app:allWindows()
    if windows[1] then
      windows[1]:focus()
    end
  end
end

local windowPicker = require('window-picker')
hs.hotkey.bind(mashApp, "P", function() windowPicker.windowFuzzySearch() end)

---- Switch apps
hs.hotkey.bind(mashApp, 'C', function() myLaunchOrFocus('Google Chrome') end)
hs.hotkey.bind(mashApp, 'B', function() myLaunchOrFocus('Brave Browser') end)
hs.hotkey.bind(mashApp, 'T', function() myLaunchOrFocus('iTerm') end)
hs.hotkey.bind(mashApp, 'V', function() myLaunchOrFocus('Visual Studio Code') end)
hs.hotkey.bind(mashApp, 'E', function() myLaunchOrFocus('IntelliJ IDEA') end)
hs.hotkey.bind(mashApp, 'K', function() myLaunchOrFocus('Slack') end)
hs.hotkey.bind(mashApp, 'S', function() myLaunchOrFocus('Spotify') end)
hs.hotkey.bind(mashApp, 'G', function() myLaunchOrFocus('Gmail') end)

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

function moveToScreen(screenPos)
  local window = hs.window.focusedWindow()
  local screen = hs.screen.find({x=screenPos, y=0})
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
  {"Code", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"com.jetbrains.intellij.ce", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Visual Studio Code", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Gmail", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"com.googlecode.iterm2", nil, rightScreen, nil, nil, nil},
  {"Slack", nil, laptop, hs.layout.left50, nil, nil},
  {"Spotify", nil, laptop, hs.layout.right50, nil, nil},
  {"SoundCleod", nil, laptop, hs.layout.right50, nil, nil},
}

local laptopLayout = {
  {"Google Chrome", nil, laptop, hs.layout.maximized, nil, nil},
  {"MacVim", nil, laptop, hs.layout.maximized, nil, nil},
  {"Emacs", nil, laptop, hs.layout.maximized, nil, nil},
  {"Code", nil, laptop, hs.layout.maximized, nil, nil},
  {"com.jetbrains.intellij.ce", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Visual Studio Code", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Gmail", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"com.googlecode.iterm2", nil, laptop, hs.layout.maximized, nil, nil},
  {"Slack", nil, laptop, hs.layout.maximized, nil, nil},
  {"Spotify", nil, laptop, hs.layout.maximized, nil, nil},
  {"SoundCleod", nil, laptop, hs.layout.maximized, nil, nil},
}

local homeLayout = {
  {"Google Chrome", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"MacVim", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Emacs", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Code", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"com.jetbrains.intellij.ce", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Visual Studio Code", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"Gmail", nil, centerScreen, hs.layout.maximized, nil, nil},
  {"com.googlecode.iterm2", nil, rightScreen, hs.layout.maximized, nil, nil},
  {"Slack", nil, laptop, hs.layout.left50, nil, nil},
  {"Spotify", nil, laptop, hs.layout.right50, nil, nil},
  {"SoundCleod", nil, laptop, hs.layout.right50, nil, nil},
}

hs.hotkey.bind(mash, "r", function()
  switchLayout()
end)

hs.hotkey.bind(mashShift, "r", function()
  fixRotation()
end)

-- Screen watcher
local lastNumberOfScreens = #hs.screen.allScreens()

function getCurrentScreens()
  local numScreens = #hs.screen.allScreens()
  local primaryScreen = hs.screen.primaryScreen():name()
  local screenLayout = {layout = laptopLayout, name = "Laptop layout"}

  if numScreens == 1 then
    screenLayout.layout = laptopLayout
    screenLayout.name = "Laptop layout"
    return screenLayout
  end

  for i, screen in pairs(hs.screen.allScreens()) do
    if screen:name() == "DELL U2715H" or screen:name() == "DELL U2717D" then
      screenLayout.layout = workLayout
      screenLayout.name = "Work layout"
      return screenLayout
    end
  end
  return screenLayout
end

function switchLayout()
  local screenLayout = getCurrentScreens()
  hs.layout.apply(screenLayout.layout)
  hs.alert.show(screenLayout.name)
end

function onScreensChanged()
  numScreens = #hs.screen.allScreens()
  hs.alert.show("Screens changed")
  print(">>>>>>Screens changed")
  if lastNumberOfScreens ~= numScreens then
    switchLayout()
    lastNumberOfScreens = numScreens
  end
end

local screenWatcher = hs.screen.watcher.new(onScreensChanged):start()

function fixRotation()
  local screenLayout = getCurrentScreens()
  if screenLayout.name == "Work layout" then
    hs.alert.show("Fixing rotation")
    local hqPrimary = hs.screen.find("DELL U2715H")
    if hqPrimary then
      local secondary = hs.screen.find("DELL U2717D")
      hqPrimary:rotate(0)
      hqPrimary:setPrimary()
      secondary:rotate(270)
    else
      hs.screen.allScreens()[1]:rotate(0)
      hs.screen.allScreens()[2]:rotate(0)
    end
    switchLayout()
  end
end

local spotifyBar = hs.menubar.new()

function SecondsToClock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return mins..":"..secs
  end
end

function setSpotifyTitle()
  local title = ""
  local track = ""
  local position = ""
  local duration = ""
  local styledTitle = nil
  local isPlaying = spotify.isPlaying()
  if spotify.isRunning() then
    track = spotify.getCurrentTrack()
    if not (track == nil) then
      position = SecondsToClock(spotify.getPosition())
      duration = SecondsToClock(spotify.getDuration())
      if isPlaying then
        symbol = "▶ "
        symbolColor = { green = 0.5 }
      else
        symbol = "■ "
        symbolColor = { red = 0.3, green = 0.3, blue = 0.3 }
      end
      styledSymbol = hs.styledtext.ansi(
       symbol,
       {
         baselineOffset = -2.0,
         color = symbolColor
       }
      )
      styledPosition = hs.styledtext.ansi(
        "["..position.."/"..duration.."]",
        {
          font = { name = "Hack", size = "8pt" },
          color = { red = 0.5, green = 0.5, blue = 0.5 },
          baselineOffset = -2.0
        }
      )
      styledTitle = hs.styledtext.ansi(
        track.." – "..spotify.getCurrentArtist().." ",
        {
          baselineOffset = -2.0
        }
      )
      styledTitle = styledSymbol .. styledTitle .. styledPosition

    end
  end
  spotifyBar:setTitle(styledTitle)
end

spotifyBar:setClickCallback(
  function(modifiers)
    if spotify.isRunning() then
      spotify.playpause()
      setSpotifyTitle()
    end
  end
)

---- Using a constantly true doWhile because there's a bug with hs.timer.doEvery that causes it to stop working
---- after about 50 iterations
local spotTimer = hs.timer.doWhile(
  function() return true end,
  function ()
    -- There's a bug in Hammerspoon's Spotify API that occasionally causes it to fail and throw an exception
    local status, err = pcall(setSpotifyTitle)
    if not status then
      print("Caught error: " .. err)
    end
  end,
  5
)

