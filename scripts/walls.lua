return {
  load = function ()
  	-- Setting this to 1 to avoid all current scaling bugs.
  	love.physics.setMeter(1)

  	-- Start out with the same random stuff each start.
  	math.randomseed(0xFaceBeef)

  	World = love.physics.newWorld()

  	Terrain = {}
  	Terrain.Body = love.physics.newBody(World, 0, 0, 'static')
  	Terrain.Stuff = {}
    -- Cleaning up the previous stuff.
  	for i = #Terrain.Stuff, 1, -1 do
  		Terrain.Stuff[i].Fixture:destroy()
  		Terrain.Stuff[i] = nil
  	end

  	-- Generates some random shapes.
  	for i = 1, 30 do
  		local p = {}

  		p.x, p.y = math.random(30, love.graphics.getWidth() - 30), math.random(30, love.graphics.getHeight() - 30)
  		local shapetype = math.random(3)
  		if shapetype == 1 then
  			local w, h, r = math.random() * 10 + 40, math.random() * 10 + 40, math.random() * math.pi * 2
  			p.Shape = love.physics.newRectangleShape(p.x, p.y, w, h, r)
  		elseif shapetype == 2 then
  			local a = math.random() * math.pi * 2
  			local x2, y2 = p.x + math.cos(a) * (math.random() * 30 + 20), p.y + math.sin(a) * (math.random() * 30 + 20)
  			p.Shape = love.physics.newEdgeShape(p.x, p.y, x2, y2)
  		else
  			local r = math.random() * 40 + 10
  			p.Shape = love.physics.newCircleShape(p.x, p.y, r)
  		end

  		p.Fixture = love.physics.newFixture(Terrain.Body, p.Shape)

  		Terrain.Stuff[i] = p
  	end

    wallStyleUseFill = true
  end,

  draw = function ()
    -- Drawing the actual view
  	local h2 = love.graphics.getHeight() / 2
  	local w = love.graphics.getWidth()
  	love.graphics.setColor (255, 255, 255)
  	for x = 0, w + raySkip, raySkip do
  		-- Clear fixture hit list
  		Ray.hitList = {}

  		-- Cast the ray and populate the hitList table
  		World:rayCast (Player.x, Player.y,
  			Player.x + math.cos(Player.rx - FOV * ((x - (w/2))/w)) * drawDistance,
  			Player.y + math.sin(Player.rx - FOV * ((x - (w/2))/w)) * drawDistance,
  			worldRayCastCallback)

  		if #Ray.hitList > 0 then
  			local min = love.graphics.getHeight()
  			for i = 1, #Ray.hitList do
  				if Ray.hitList[i].fraction < min then
  					min = Ray.hitList[i].fraction
  				end
  			end

  			assert (min ~= 0)	-- Would cause a divide by zero exception

  			-- Assign color based on lighting around the intersection
  			love.graphics.setColor (255 * (1 - min), 255 * (1 - min), 255 * (1 - min))

        -- TODO fisheye effect almost fixed, now it's doing an S-shaped effect
        min = min * math.cos(FOV * ((x - (w/2))/w))
        local wallY = h2 - drawHeight/(min * h2) + Player.ry
        if wallStyleUseFill then
          love.graphics.rectangle ('fill', w - x, wallY, raySkip, (2 * drawHeight) / (min * h2))
        else
          love.graphics.rectangle ('line', w - x, wallY, raySkip, (2 * drawHeight) / (min * h2))
        end
  			-- love.graphics.line(
  			-- 	w - x,
  			-- 	h2 + drawHeight/(min * h2) + Player.ry,
  			-- 	w - x,
  			-- 	h2 - drawHeight/(min * h2) + Player.ry)
  		end
  	end
  end
}
