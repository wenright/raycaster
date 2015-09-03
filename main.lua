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

	raySkip = 1
	FOV = 75 * math.pi / 180
	drawDistance = 500
	drawHeight = love.window.getHeight() * 5
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

	-- Draw framerate
	love.graphics.setColor(0, 255, 0)
	love.graphics.print(love.timer.getFPS(), love.window.getWidth() - 30, 10)
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
  	Player:mousemoved (dx, dy)
	end
end
