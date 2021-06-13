-- based
Magnet = Object:extend()

-- input: direction of magnet, x/y, and width/height
-- function: constructor for a magnet object
function Magnet:new(dir, x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.vel = 0
  self.dir = dir
  self.previous = false
end

-- updates position of magnet
function Magnet:update(dt)
  if self.dir == "left" then
    self.x = self.x + self.vel*dt
  else
    self.x = self.x - self.vel*dt
  end
end

-- reverses polarity of magnet
function Magnet:bounce(strength)
  self.vel = 0
  if self.dir == "left" then
    self.x = self.x - strength
  else
    self.x = self.x + strength
  end
  self.previous = true
end

function Magnet:reversebounce(strength)
  self.vel = 0
  if self.dir == "left" then
    self.x = self.x + strength
  else
    self.x = self.x - strength
  end
  self.previous = true
end

-- makes sure magnet does not cross centre of screen
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

-- makes sure magnet does not go out of bounds
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

-- input: acceleration
-- updates acceleration of magnet
function Magnet:accelerate(speed)
    self.vel = self.vel + speed
end

function Magnet:getPrevious()
  return self.previous
end

function Magnet:setPrevious()
  self.previous = false
end

-- draws magnet to the screen
function Magnet:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

function Magnet:getMagnetProperties()
  return self.x, self.y, self.height, self.width
end
