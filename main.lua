
function newButton(text, fn)
  return {
    text = text,
    fn = fn
  }
end

local buttons = {}

function love.load()
  Object = require "classic"
  require "player"
  love.graphics.setDefaultFilter('nearest', 'nearest')

-- menu logic (WIP)
  currentScreen = "menu"
  table.insert(buttons, newButton("Start",
    function()
      print("Starting Game")
    end
  ))

  table.insert(buttons, newButton("Exit",
    function()
      love.event.quit(0)
    end
  ))

-- useful global/local variables?
  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()
  magnetAccel = 10
  releaseFrames = 60
  releaseCounter = 0
  strength = 15

  playerL = Magnet("left", 0, 650, 50, 20)
  playerR = Magnet("right", love.graphics.getWidth()-50, 650, 50, 20)
end

function love.update(dt)
  if (love.keyboard.isDown("space") == false) and playerL:getPrevious() then
    if releaseCounter < releaseFrames then
      releaseCounter = releaseCounter + 1
    else
      releaseCounter = 0
      playerL:setPrevious()
    end
  elseif love.keyboard.isDown('space') then
    playerL:bounce(strength)
    playerR:bounce(strength)
  else
    playerL:update(dt)
    playerR:update(dt)
    playerL:accelerate(magnetAccel)
    playerR:accelerate(magnetAccel)
  end
  playerL:centreCollision()
  playerR:centreCollision()
  playerL:wallCollision()
  playerR:wallCollision()
end

function love.draw()
  --for i, button in ipairs(buttons) do
  playerL:draw()
  playerR:draw()
end
