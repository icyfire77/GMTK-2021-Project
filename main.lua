
function love.load()
  Object = require "classic"
  require "player"
  love.graphics.setDefaultFilter('nearest', 'nearest')

  currentScreen = "menu"
  magnetAccel = 10

  playerL = Magnet("left", 0, 650, 50, 20)
  playerR = Magnet("right", love.graphics.getWidth()-50, 650, 50, 20)
end

function love.update(dt)
  -- could condense these into less functions tbh
  playerL:update(dt)
  playerR:update(dt)
  playerL:accelerate(magnetAccel)
  playerR:accelerate(magnetAccel)
  playerL:centreCollision()
  playerR:centreCollision()
end

function love.draw()
  playerL:draw()
  playerR:draw()
end
