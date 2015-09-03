return {
  load = function (self)
    self.x, self.y, self.rx, self.ry = 100, 100, 0, 0
    self.speed = 75
  end,

  update = function (self, dt)
    -- TODO limit velocity for moving diagonally
    -- TODO limit velocity with delta time
    if love.keyboard.isDown('s', 'down') then
      self.x = self.x - math.cos(self.rx) * dt * self.speed
      self.y = self.y - math.sin(self.rx) * dt * self.speed
    end
    if love.keyboard.isDown('w', 'up') then
      self.x = self.x + math.cos(self.rx) * dt * self.speed
      self.y = self.y + math.sin(self.rx) * dt * self.speed
    end
    if love.keyboard.isDown('d', 'right') then
      self.x = self.x + math.cos(self.rx + math.pi/2) * dt * self.speed
      self.y = self.y + math.sin(self.rx + math.pi/2) * dt * self.speed
    end
    if love.keyboard.isDown('a', 'left') then
      self.x = self.x - math.cos(self.rx + math.pi/2) * dt * self.speed
      self.y = self.y - math.sin(self.rx + math.pi/2) * dt * self.speed
    end
  end,

  draw = function (self)

  end,

  mousemoved = function (self, dx, dy)
    self.rx = self.rx + dx / 750
    self.ry = self.ry - dy
  end
}
