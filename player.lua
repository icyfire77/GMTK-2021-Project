-- based
Magnet = Object:extend()

function Magnet:new(dir, x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.vel = 0
  self.dir = dir
end

function Magnet:update(dt)

  if self.dir == "left" then
    self.x = self.x + self.vel*dt
  else
    self.x = self.x - self.vel*dt
  end
end

function Magnet:centreCollision()
  if self.dir == "left" then
    if self.x > love.graphics.getWidth()/2 - self.width then
      self.vel = 0
      self.x = love.graphics.getWidth()/2 - self.width
    end
  else
    if self.x < love.graphics.getWidth()/2 then
      self.vel = 0
      self.x = love.graphics.getWidth()/2
    end
  end
end

function Magnet:accelerate(speed)
    self.vel = self.vel + speed
end

function Magnet:draw()
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end
