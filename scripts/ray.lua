Ray = {
  x1 = 0,
  y1 = 0,
  x2 = 5,
  y2 = 5,
  hitList = {}
}

raySkip = 1
FOV = 75 * math.pi / 180
drawDistance = 500
drawHeight = love.window.getHeight() * 5

function worldRayCastCallback (fixture, x, y, xn, yn, fraction)
	local hit = {}
	hit.fixture = fixture
	hit.x, hit.y = x, y
	hit.xn, hit.yn = xn, yn
	hit.fraction = fraction

	table.insert(Ray.hitList, hit)

	return 1
end
