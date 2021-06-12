
function newButton(text, fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false
  }
end

local buttons = {}
local creditsVel = 100

function love.load()
  -- love.graphics.setBackgroundColor(0.5, 0.5, 0.5, 1) -- for debugging
  Object = require "classic"
  require "player"
  require "levels"
  love.graphics.setDefaultFilter('nearest', 'nearest')
  menuFont = love.graphics.newFont("Mick Caster.ttf", 40)

  -- useful global/local variables?
  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()
  creditsY = windowHeight
  magnetAccel = 10
  releaseFrames = 0
  releaseCounter = 0
  strength = 5

  playerL = Magnet("left", 0, 650, 50, 20)
  playerR = Magnet("right", love.graphics.getWidth() -50, 650, 50, 20)


  levels = Levels()

  -- menu logic (WIP)
  currentScreen = "menu"
  table.insert(buttons, newButton("Start",
    function()
      -- Likely first change this to some tutorial page later
      currentScreen = "levelOne"
      print(currentScreen)
      sound = love.audio.newSource(
        "Different_Heaven_-_Nekozilla.mp3", "stream")
      love.audio.play(sound)
      sound:setVolume(0.3)
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
      levels:setLevel(1)
      levels:generate(sound:tell())
      levels:update(dt)

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
  elseif currentScreen == "credits" then
    creditsY = creditsY - creditsVel*dt
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
    levels:draw()
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
  if currentScreen == "credits" then
    local creditsText = "Haha Magnet Game" -- TODO: WRITE ACTUAL CREDITS
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(creditsText,
      menuFont, -- TODO: CHANGE MENU FONT TO SOME OTHER FONT
      windowWidth/2 - menuFont:getWidth(creditsText)/2, creditsY)
  end
end

function love.keypressed(key)
  if currentScreen == "credits" and key == "escape" then
    currentScreen = "menu"
  end
end
