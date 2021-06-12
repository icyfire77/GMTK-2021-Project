-- based
Magnet = Object:extend()

function Magnet:new(dir, x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.vel = 0
  self.dir = dir
  self.previous = false
end

function Magnet:update(dt)
  if self.dir == "left" then
    self.x = self.x + self.vel*dt
  else
    self.x = self.x - self.vel*dt
  end
end

function Magnet:bounce(strength)
  self.vel = 0
  if self.dir == "left" then
    self.x = self.x - strength
  else
    self.x = self.x + strength
  end
  self.previous = true
end

function Magnet:centreCollision()
  if self.dir == "left" then
    if self.x > windowWidth/2 - self.width then
      self.vel = 0
      self.x = windowWidth/2 - self.width
    end
  else
    if self.x < windowWidth/2 then
      self.vel = 0
      self.x = windowWidth/2
    end
  end
end

function Magnet:wallCollision()
  if self.dir == "left" then
    if self.x < 0 then
      self.vel = 0
      self.x = 0
    end
  else
    if self.x > windowWidth - self.width then
      self.vel = 0
      self.x = windowWidth - self.width
    end
  end
end

function Magnet:accelerate(speed)
    self.vel = self.vel + speed
end

function Magnet:getPrevious()
  return self.previous
end

function Magnet:setPrevious()
  self.previous = false
end

function Magnet:getXLocation()
  return self.x
end

function Magnet:draw()
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end
