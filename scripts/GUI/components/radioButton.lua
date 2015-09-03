local RadioButton = {}

function RadioButton:new (x, y, w, h, start, click, color, title)
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.x = x or 0
  o.y = y or 0
  o.w = w or 10
  o.h = h or 10
  o.active = start or false
  o.click = click or function () end
  o.color = color or {255, 255, 255}
  o.title = title or ''

  return o
end

function RadioButton:update (dt)
  local x, y = love.mouse.getPosition()

  self.hovering = x <= self.x + self.w and x >= self.x and y <= self.y + self.h and y >= self.y

  if self.hovering then
    love.mouse.setCursor (handCursor)
  end
end

function RadioButton:draw ()
  love.graphics.setColor(self.color)

  love.graphics.print(self.title, self.x, self.y - 20)

  if self.active then
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
  else
    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
  end
end

function RadioButton:mousemoved (dx, dy)

end

function RadioButton:mousepressed (x, y, b)
  if self.hovering then
    self.active = not self.active
    self.click (self.active)
  end
end

function RadioButton:mousereleased ()

end

return RadioButton
