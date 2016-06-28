local Slider = require 'scripts.GUI.components.slider'
local RadioButton = require 'scripts.GUI.components.radioButton'

local Settings = {components = {}}

function Settings.load ()
  Settings.isOpen = false

  table.insert(Settings.components, Slider:new (
    20,                             -- x
    love.graphics.getHeight() - 50,   -- y
    love.graphics.getWidth() / 5,     -- width
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
    love.graphics.getHeight() / 2,    -- y
    30,                             -- width
    30,                             -- height
    true,                           -- active or not
    function (active)               -- function called when clicked
      wallStyleUseFill = active
    end,
    {150, 255, 20},                 -- color
    'Fill Rectangles'               -- title
  ))

  table.insert(Settings.components, RadioButton:new (
    20,                             -- x
    love.graphics.getHeight() / 2 + 100,-- y
    30,                             -- width
    30,                             -- height
    love.window.getFullscreen (),   -- active or not
    function (active)               -- function called when clicked
      love.window.setFullscreen(active)
    end,
    {150, 255, 20},                 -- color
    'Fullscreen'                    -- title
  ))
end

function Settings.update (dt)
  if Settings.isOpen then
    -- Set cursor to default
    love.mouse.setCursor ()

    for _, component in pairs (Settings.components) do
      component:update (dt)
    end
  end
end

function Settings.draw ()
  -- Draw framerate
  love.graphics.setColor(0, 255, 0)
  love.graphics.print(love.timer.getFPS(), love.graphics.getWidth() - 30, 10)

  if Settings.isOpen then
    -- Dim the background
    love.graphics.setColor(0, 0, 0, 150)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

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

function Settings.mousepressed (x, y, b)
  if Settings.isOpen then
    for _, component in pairs (Settings.components) do
      component:mousepressed (x, y, b)
    end
  end
end

function Settings.mousereleased ()
  if Settings.isOpen then
    for _, component in pairs (Settings.components) do
      component:mousereleased ()
    end
  end
end

return Settings
