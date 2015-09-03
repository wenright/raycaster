local Slider = require 'scripts.GUI.components.slider'
local RadioButton = require 'scripts.GUI.components.radiobutton'

local Settings = {components = {}}

function Settings.load ()
  Settings.isOpen = false

  table.insert(Settings.components, Slider:new (
    20,                             -- x
    love.window.getHeight() - 50,   -- y
    love.window.getWidth() / 5,     -- width
    30,                             -- height
    1,                              -- min
    love.graphics.getWidth(),       -- max
    0,                              -- start
    function (pos)                  -- function called each frame
      raySkip = math.pow(pos, 0.5)
    end,
    {150, 255, 20},                 -- color
    'Quality'                       -- title
  ))

  table.insert(Settings.components, RadioButton:new (
    20,                             -- x
    love.window.getHeight() / 2,    -- y
    30,                             -- width
    30,                             -- height
    true,                           -- active or not
    function (active)               -- function called each frame
      -- TODO
    end,
    {150, 255, 20},                 -- color
    'Fill Rectangles'               -- title
  ))
end

function Settings.update (dt)
  if Settings.isOpen then
    for _, component in pairs (Settings.components) do
      component:update (dt)
    end
  end
end

function Settings.draw ()
  if Settings.isOpen then
    -- Dim the background
    love.graphics.setColor(0, 0, 0, 150)
    love.graphics.rectangle('fill', 0, 0, love.window.getWidth(), love.window.getHeight())

    -- Set cursor to default
    love.mouse.setCursor ()

    love.graphics.setColor (150, 255, 20)

    for _, component in pairs (Settings.components) do
      component:draw ()
    end

    love.graphics.print('Settings', love.graphics.getWidth() / 2 - 25, 20)
  end
end

function Settings.keypressed (key)
  if key == 'f1' then
    love.mouse.setRelativeMode (Settings.isOpen)
    Settings.isOpen = not Settings.isOpen
  end
end

function Settings.mousemoved (dx, dy)
  if Settings.isOpen then
    for _, component in pairs (Settings.components) do
      component:mousemoved (dx, dy)
    end
  end
end

return Settings
