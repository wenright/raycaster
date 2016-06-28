require 'scripts.ray'
require 'scripts.utils.math'
Player = require 'scripts.player'
Minimap = require 'scripts.minimap'
Walls = require 'scripts.walls'
Settings = require 'scripts.GUI.settings'

function love.load ()
	love.mouse.setRelativeMode (true)
	handCursor = love.mouse.getSystemCursor('hand')

	Player:load()
	Walls:load()
	Settings:load()
end

function love.update (dt)
	Player:update(dt)
	World:update(dt)
	Settings.update(dt)
end

function love.draw ()
	Player:draw()
  Walls.draw()
	Minimap.draw()
	Settings.draw()
end

function love.keypressed (key)
  if key == 'escape' then
    love.event.quit()
	end

	Settings.keypressed (key)
end

function love.mousemoved(x, y, dx, dy)
	if Settings.isOpen then
		Settings.mousemoved (dx, dy)
	else
		-- Don't allow player to look around if in settings menu
  	Player:mousemoved (dx, dy)
	end
end

function love.mousepressed (x, y, b)
	Settings.mousepressed (x, y, b)
end

function love.mousereleased ()
	Settings.mousereleased ()
end
