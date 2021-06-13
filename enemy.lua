-- actually based as hell
Enemy = Object:extend()

-- enemy constructor, takes xy coords and width/height
function Enemy:new(x, y, w, h, v, t)
  self.x, self.y = x, y
  self.width, self.height = w, h
  self.speed = v
  self.timestamp = t
  self.out = false
end

-- move enemy down the screen at constant velocity
function Enemy:update(dt)
  -- print(dt)
  -- self.y = self.y + self.speed * dt
end

function Enemy:draw(t)
  love.graphics.rectangle("fill", self.x, self.y + self.speed * (t - self.timestamp), self.width, self.height)
  if self.speed * (t - self.timestamp) > 800 then
    self.out = true
  end
end

function Enemy:getEnemyProperties()
  return self.x, self.y, self.height, self.width
end
