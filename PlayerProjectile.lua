-- code copied from Enemy.LUA
PlayerProjectile = Object:extend()

function PlayerProjectile:new(x, y, w, h)
  self.x, self.y = x, y
  self.width, self.height = w, h
end

function PlayerProjectile:update(dt)
  self.y = self.y - dt
end

function PlayerProjectile:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
