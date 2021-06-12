-- actually based as hell
Enemy = Object:extend()

-- enemy constructor, takes xy coords and width/height
function Enemy:new(x, y, w, h)
  self.x, self.y = x, y
  self.width, self.height = w, h
end

-- move enemy down the screen at constant velocity
function Enemy:update(dt)
  self.y = self.y + 10 * dt
end

function Enemy:draw()
  love.graphics.circle("fill", self.x, self.y, self.width, self.height)
end
