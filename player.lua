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
    self.x = self.x - self.vel*dt
  else
    self.x = self.x + self.vel*dt
end

function Magnet:accelerate(speed)
  if self.dir == "left" then
    self.vel = self.vel - speed
  else
    self.vel = self.vel + speed
  end
end

function Magnet:draw()
end
