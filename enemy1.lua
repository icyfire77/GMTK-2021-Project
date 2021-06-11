-- actually based as hell
Enemy = Object:extend()

function Enemy:new(x, y, w, h)
  self.x, self.y = x, y
  self.width, self.height = w, h
  self.velocity = 0
end

function Enemy:udpate()
  if self.dir == "a" then
    self.x = self.x - self.velocity * dt
  end
  if self.dir == "d" then
    self.x = self.x + self.velocity * dt
  end
end

function Enemy:draw()
  love.graphics.circle("fill", x, y, w, h)
end
