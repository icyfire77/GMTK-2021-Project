
function newButton(text, fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false,
    x = 0,
    y = 0
  }
end

local menuButtons = {}
local levelButtons = {}

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
  strength = 10

  -- for level select
  clickedx = 0
  diffx = 0

  playerL = Magnet("left", 0, 650, 50, 20)
  playerR = Magnet("right", love.graphics.getWidth() -50, 650, 50, 20)


  levels = Levels()

  -- menu logic (WIP)
  currentScreen = "menu"
  table.insert(menuButtons, newButton("Start",
    function()
      -- Likely first change this to some tutorial page later
      
      -- currentScreen = "levelOne"
      -- print(currentScreen)
      -- sound = love.audio.newSource(
      --   "Different_Heaven_-_Nekozilla.mp3", "stream")
      -- love.audio.play(sound)
      -- sound:setVolume(0.3)
      -- levels:setLevel(1)

      currentScreen = "SelectLevel"
    end
  ))

  table.insert(menuButtons, newButton("Credits",
    function()
      currentScreen = "credits"
      print("none for now, WIP")
    end
  ))

  table.insert(menuButtons, newButton("Exit",
    function()
      love.event.quit(0)
    end
  ))
end

function love.update(dt)
  if currentScreen:find("level", 1, true) == 1 then
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
      checkCollisions()
  elseif currentScreen == "credits" then
    creditsY = creditsY - creditsVel*dt
  end
end

function love.draw()
  local buttonWidth = windowWidth/3
  local buttonHeight = 70
  local margin = 30

  local totalHeight = (buttonHeight + margin)*#menuButtons
  local cursorY = 0

  -- for level select
  local gap = 500
  local levelButtonRadius = 200


  if currentScreen:find("level", 1, true) == 1 then
    playerL:draw()
    playerR:draw()
    levels:draw()
    love.graphics.print(levels.score, menuFont, 10, 0)
  end

  if currentScreen == "menu" then
    for i, button in ipairs(menuButtons) do
      button.last = button.now

      button.x = windowWidth/2 - buttonWidth/2
      button.y = windowHeight/2 - totalHeight/2 + cursorY

      local colour = {0.5, 0.8, 0.7, 1}
      local mx, my = love.mouse.getPosition()

      local hot = mx > button.x and mx < button.x + buttonWidth and
        my > button.y and my < button.y + buttonHeight

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
      button.x, button.y,
      buttonWidth, buttonHeight)

      local textWidth = menuFont:getWidth(button.text)
      local textHeight = menuFont:getHeight(button.text)

      love.graphics.setColor(0, 0, 0, 1)
      love.graphics.print(
        button.text,
        menuFont,
        windowWidth/2 - textWidth/2,
        button.y + textHeight/5)

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

  if currentScreen == "SelectLevel" then
    if #levelButtons <= 0 then
      table.insert(levelButtons, newButton("Level 1",
        function()
          currentScreen = "levelOne"
          sound = love.audio.newSource(
            "Different_Heaven_-_Nekozilla.mp3", "stream")
          love.audio.play(sound)
          sound:setVolume(0.3)
          levels:setLevel(1)
        end
      ))
      table.insert(levelButtons, newButton("Level 2",
        function()
          currentScreen = "levelTwo"
          sound = love.audio.newSource(
            "Different_Heaven_-_Nekozilla.mp3", "stream")
          love.audio.play(sound)
          sound:setVolume(0.3)
          levels:setLevel(2)
        end
      ))
      table.insert(levelButtons, newButton("Coming Soon",
        function()

        end
      ))
      for i, button in ipairs(levelButtons) do
        button.now = true
        button.x = windowWidth/2 + gap * (i-1)
        button.y = windowHeight/2 
      end
    end

    for i, button in ipairs(levelButtons) do
      button.last = button.now

      local colour = {0.5, 0.8, 0.7, 1}
      local mx, my = love.mouse.getPosition()
      local actualdiffx = 0

      local hot = (button.x - mx) * (button.x - mx) + (button.y - my) * (button.y - my) <= levelButtonRadius * levelButtonRadius

      if hot then
        colour = {0.7, 0.9, 0.8, 1}
      end

      button.now = love.mouse.isDown(1)

      if button.now and not button.last then
        clickedx = mx
        if hot then
          button.fn()
        end
      end
      if not button.now and button.last then
        if clickedx > 0 then
          if i == 1 then
            if button.x + diffx > windowWidth then
              diffx = windowWidth - button.x
            end
            if levelButtons[#levelButtons].x + diffx < 0 then
              diffx = 0 - levelButtons[#levelButtons].x
            end
          end
          button.x = button.x + diffx
        end  
        actualdiffx = 0
        if i == #levelButtons then
          diffx = 0
        end
      end
      if button.now then
        diffx = mx - clickedx
        -- just to catch in the bery beginning button.now == true but diffx shouldnt be set
        if clickedx <= 0 then
          actualdiffx = 0
        else
          actualdiffx = diffx
        end
      end
      -- setColor uses RGB and alpha
      love.graphics.setColor(unpack(colour))
      love.graphics.circle("fill",
      button.x + actualdiffx, button.y,
      levelButtonRadius)

      local textWidth = menuFont:getWidth(button.text)
      local textHeight = menuFont:getHeight(button.text)

      love.graphics.setColor(0, 0, 0, 1)
      love.graphics.print(
        button.text,
        menuFont,
        button.x - textWidth/2 + actualdiffx,
        button.y - textHeight/5)

    end
  end
end

function love.keypressed(key)
  if currentScreen == "credits" and key == "escape" then
    currentScreen = "menu"
  end
end

function checkCollisions()
  LXLocation, LYLocation, MagnetHeight, MagnetWidth = playerL:getMagnetProperties()
  RXLocation, RYLocation, MagnetHeight2, MagnetWidth2 = playerR:getMagnetProperties()
  levels:resolveLCollisions(LXLocation, LYLocation, MagnetHeight, MagnetWidth)
  levels:resolveRCollisions(RXLocation, RYLocation, MagnetHeight2, MagnetWidth2)
end
