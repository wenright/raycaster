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

  local hovering = x >= self.x + self.w and x <= self.x + self.w and y <= self.y + self.h and y >= self.y

  if hovering then
    love.mouse.setCursor (handCursor)
  end
end

function RadioButton:draw ()
  love.graphics.setColor(self.color)

  love.graphics.print(self.title, self.x, self.y - 20)
  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)

  if self.active then
    -- TODO draw check mark or x or something
  else

  end
end

function RadioButton:mousemoved (dx, dy)

end

return RadioButton
