local Slider = {}

function Slider:new (x, y, w, h, min, max, start, step, color, title)
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.x = x or 0
  o.y = y or 0
  o.w = w or 100
  o.h = h or 10
  o.min = min or 0
  o.max = max or 1
  o.pos = start or 0
  o.step = step or function () end
  o.color = color or {255, 255, 255}
  o.title = title
  o.grabbed = false
  o.sliderWidth = h

  return o
end

function Slider:update (dt)
  local x, y = love.mouse.getPosition()

  local hovering = x >= self.x + self.pos * self.w and x <= self.x + self.sliderWidth + self.pos * self.w and y <= self.y + self.h and y >= self.y

  if not love.mouse.isDown () then
    self.grabbed = false
  end

  if love.mouse.isDown ('l') then
    if not self.grabbed then
      self.grabbed = hovering
    end
	end

  if hovering then
    love.mouse.setCursor (handCursor)
  end

  self.step (math.lerp (self.min, self.max, self.pos))
end

function Slider:draw ()
  love.graphics.setColor(self.color)

  love.graphics.rectangle('line', self.x, self.y, self.w + self.sliderWidth, self.h)            -- Border
  love.graphics.rectangle('fill', self.x + self.pos * self.w, self.y, self.sliderWidth, self.h) -- Slider
  love.graphics.print(self.title, self.x, self.y - 20)                                          -- Title

end

function Slider:mousemoved (dx)
  if self.grabbed then
    self.pos = self.pos + dx / self.w
    self.pos = math.clamp (self.pos, 0, 1)
  end
end

return Slider
