
function newButton(text, fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false
  }
end

local buttons = {}

function love.load()
  Object = require "classic"
  require "player"
  require "endless"
  love.graphics.setDefaultFilter('nearest', 'nearest')
  menuFont = love.graphics.newFont("Mick Caster.ttf", 40)

  -- useful global/local variables?
  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()
  magnetAccel = 10
  releaseFrames = 60
  releaseCounter = 0
  strength = 15

  playerL = Magnet("left", 0, 650, 50, 20)
  playerR = Magnet("right", love.graphics.getWidth()-50, 650, 50, 20)


  num_enemies = 100      -- number of enemies to generate
  rate = 20             -- rate per minute at which you want enemies to fall
  endless_enemy_hub = Endless(num_enemies, rate)
  endless_enemy_hub:generate()

  -- menu logic (WIP)
  currentScreen = "menu"
  table.insert(buttons, newButton("Start",
    function()
      -- Likely first change this to some tutorial page later
      currentScreen = "levelOne"
      print(currentScreen)
    end
  ))

  table.insert(buttons, newButton("Credits",
    function()
      currentScreen = "credits"
      print("none for now, WIP")
    end
  ))

  table.insert(buttons, newButton("Exit",
    function()
      love.event.quit(0)
    end
  ))
end

function love.update(dt)
  if currentScreen == "levelOne" then

      endless_enemy_hub:update(1)

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
      checkCollisions()
    end
end

function love.draw()
  local buttonWidth = windowWidth/3
  local buttonHeight = 70
  local margin = 30

  local totalHeight = (buttonHeight + margin)*#buttons
  local cursorY = 0

  if currentScreen == "levelOne" then
    playerL:draw()
    playerR:draw()
    endless_enemy_hub:draw()
  end

  if currentScreen == "menu" then
    for i, button in ipairs(buttons) do
      button.last = button.now

      local buttonX = windowWidth/2 - buttonWidth/2
      local buttonY = windowHeight/2 - totalHeight/2 + cursorY

      local colour = {0.5, 0.8, 0.7, 1}
      local mx, my = love.mouse.getPosition()

      local hot = mx > buttonX and mx < buttonX + buttonWidth and
        my > buttonY and my < buttonY + buttonHeight

      if hot then
        colour = {0.7, 0.9, 0.8, 1}
      end

      button.now = love.mouse.isDown(1)
      if button.now and not button.last and hot then
        button.fn()
      end

      -- setColor uses RGB and alpha
      love.graphics.setColor(unpack(colour))
      love.graphics.rectangle("fill",
      buttonX, buttonY,
      buttonWidth, buttonHeight)

      local textWidth = menuFont:getWidth(button.text)
      local textHeight = menuFont:getHeight(button.text)

      love.graphics.setColor(0, 0, 0, 1)
      love.graphics.print(
        button.text,
        menuFont,
        windowWidth/2 - textWidth/2,
        buttonY + textHeight/5)

        cursorY = cursorY + (buttonHeight + margin)
    end
  end
end

function checkCollisions()
  for i = 1, num_enemies do
    LXLocation, LYLocation, MagnetHeight, MagnetWidth = playerL:getMagnetProperties()
    RXLocation, RYLocation, MagnetHeight, MagnetWidth = playerR:getMagnetProperties()
    EXLocation, EYLocation, EnemyHeight, EnemyWidth = endless_enemy_hub:searchList(i)
    if EXLocation + EnemyWidth > LXLocation
    and EXLocation < LXLocation + MagnetWidth
    and EYLocation + EnemyHeight > LYLocation
    and EYLocation < LYLocation + MagnetHeight or
    EXLocation + EnemyWidth > RXLocation
    and EXLocation < RXLocation + MagnetWidth
    and EYLocation + EnemyHeight > RYLocation
    and EYLocation < RYLocation + MagnetHeight then
      print("Collision")
    end
  end
end
