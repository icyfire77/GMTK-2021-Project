-- code copied from Enemy.LUA
EnemyProjectile = Object:extend()

function EnemyProjectile:new(x, y, w, h)
  self.x, self.y = x, y
  self.width, self.height = w, h
end

function EnemyProjectile:update(dt)
  -- maybe make a more complex function for EnemyProjectile later
  self.y = self.y - dt
end

function EnemyProjectile:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
