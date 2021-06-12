-- actually based as hell
Enemy = Object:extend()

function Enemy:new(x, y, w, h)
  self.x, self.y = x, y
  self.width, self.height = w, h
end

function Enemy:update(dt)
  self.y = self.y + dt
end

function Enemy:draw()
  love.graphics.circle("fill", self.x, self.y, self.width, self.height)
end
