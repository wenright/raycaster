return {
  draw = function ()
    love.graphics.push ()
    love.graphics.scale (0.25, 0.25)

    -- Preven minimap FOV indicator from going through to screen
    love.graphics.setScissor (0, 0, love.window.getWidth () / 4, love.window.getHeight () / 4)

  	love.graphics.setColor (50, 50, 50)
  	love.graphics.rectangle ('fill', 0, 0, love.window.getWidth (), love.window.getHeight ())

  	love.graphics.setColor (255, 255, 255)
  	love.graphics.rectangle ('line', 0, 0, love.window.getWidth (), love.window.getHeight ())

  	for i, v in ipairs (Terrain.Stuff) do
  		if v.Shape:getType () == "polygon" then
  			love.graphics.polygon ("line", Terrain.Body:getWorldPoints (v.Shape:getPoints ()))
  		elseif v.Shape:getType () == "edge" then
  			love.graphics.line (Terrain.Body:getWorldPoints (v.Shape:getPoints ()))
  		else
  			local x, y = Terrain.Body:getWorldPoints (v.x, v.y)
  			love.graphics.circle ("line", x, y, v.Shape:getRadius ())
  		end
  	end

  	-- Draw the Player's FOV on the mini map
  	love.graphics.setColor (255, 155, 101, 3)
  	love.graphics.line (Player.x, Player.y, Player.x + math.cos(Player.rx + FOV / 2) * 500, Player.y + math.sin(Player.rx + FOV / 2) * 500)
  	love.graphics.line (Player.x, Player.y, Player.x + math.cos(Player.rx - FOV / 2) * 500, Player.y + math.sin(Player.rx - FOV / 2) * 500)

    love.graphics.setColor (100, 255, 200, 255)
    love.graphics.point (Player.x, Player.y)

    love.graphics.setColor (230, 250, 220, 25)
    love.graphics.arc ('fill', Player.x, Player.y, drawDistance, Player.rx - FOV / 2, Player.rx + FOV / 2)

  	-- End drawing mini map
    love.graphics.setScissor ()
  	love.graphics.pop ()
  end
}
