Levels = Object:extend()

function Levels:new()
    require "enemy"
    self.level = 0
    self.count = 0
    self.score = 0
    self.enemy_list = {}
    self.timings = {
        {4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20, 20.5, 21, 21.5, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 35, 35.5, 37, 37, 38, 38, 38.5, 39, 39, 39.5, 40, 40.5, 41, 41.5, 42, 43, 43.25, 43.5, 43.75, 44, 45, 46, 46.5, 47, 48, 48, 48, 48, 49, 49, 49, 49, 50, 50, 50, 50, 51.5, 51.5, 51.5, 51.5, 51.5, 52, 52, 52, 52, 52, 10000},
        {2, 2, 2.6, 2.6, 4, 4, 4.6, 4.6, 6, 6, 6.6, 6.6, 8, 8, 8.6, 8.6, 10, 10, 10.6, 10.6, 12, 12, 12.6, 12.6, 14, 14.5, 15, 15.5, 16, 16.5, 17, 17.5, 10000}
    }
    self.positions = {
        {0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.65, 0.35, 0.55, 0.45, 0.2, 0.25, 0.3, 0.25, 0.3, 0.35, 0.4, 0.5, 0.55, 0.6, 0.7, 0.8, 0.2, 0.7, 0.4, 0.1, 0.9, 0.6, 0.5, 0.5, 0.9, 0.1, 0.1, 0.5, 0.5, 0.7, 0.3, 0.5, 0.3, 0.7, 0.3, 0.4, 0.5, 0.7, 0.6, 0.5, 0.3, 0.5, 0.4, 0.3, 0.2, 0.5, 0.6, 0.7, 0.8, 0.9, 0.2, 0.7, 0.4, 0.5, 0.8, 0.6, 0.4, 0.2, 0.8, 0.6, 0.4, 0.2, 0.8, 0.6, 0.4, 0.2, 0.9, 0.7, 0.5, 0.3, 0.1, 0.9, 0.7, 0.5, 0.3, 0.1, -1000},
        {0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.65, 0.35, 0.55, 0.45, 0.2, 0.25, 0.3, 0.25, 0.3, 0.35, 0.4, 0.45, -1000}
    }
    self.bpm = {
        120,
        128
    }
    self.hit = function()
        hitsound = love.audio.newSource("hit.mp3", "stream")
        hitsound:setVolume(0.5)
        love.audio.play(hitsound)
    end
end

-- Set the level to 1 before generate
function Levels:generate(t)
    enemy_sizew, enemy_sizeh = 60, 10
    enemy_speed = 500
    offset = 0
    -- change this to true for offsets
    if true then
        offset = (windowHeight-30)/enemy_speed
    end
    if  self.count < #self.timings[self.level] then
        while t + offset >= self.timings[self.level][self.count + 1]*60/self.bpm[self.level] do
            self.count = self.count + 1
            x_pos = windowWidth * self.positions[self.level][self.count] - enemy_sizew/2
            y_pos = 0 -- for now
            curr_enemy = Enemy(x_pos, y_pos, enemy_sizew, enemy_sizeh, enemy_speed, t)
            table.insert(self.enemy_list, curr_enemy)
            print("enemy added")
            if self.count + 1 > #self.timings[self.level] then
                break
            end
        end
    end
end

function Levels:update(dt)
  for i, enemy in pairs(self.enemy_list) do
    -- self.enemy_list[i]:update(dt)
    if self.enemy_list[i].y > windowHeight + 50  then
      table.remove(self.enemy_list, i)
    end

  end

end

function Levels:draw(t)
    for i, enemy in pairs(self.enemy_list) do
      self.enemy_list[i]:draw(t)
    end
end

function Levels:setLevel(lvl)
    self.level = lvl
    self.score = 0
    self.count = 0
end

function Levels:resolveDoubleCollisions(LXLocation, LYLocation, RXLocation, MagnetHeight, MagnetWidth)
  for i, enemy in pairs(self.enemy_list) do
    EXLocation, EYLocation, EnemyHeight, EnemyWidth = self.enemy_list[i]:getEnemyProperties()
    if EXLocation > LXLocation
    and EXLocation < LXLocation + MagnetWidth
    and EXLocation + EnemyWidth > RXLocation
    and EXLocation + EnemyWidth < RXLocation + MagnetWidth
    and EYLocation + EnemyHeight > LYLocation
    and EYLocation < LYLocation + MagnetHeight then
      print("Double!")
      for j=1,10 do
        self.score = self.score + self.enemy_list[i].point
      end
      self.enemy_list[i].point = 0
      -- include this if you want the block to disappear
      self.enemy_list[i]:begone()
      self.hit()

      return true
    else
      return false
    end
  end
end

function Levels:resolveLCollisions(LXLocation, LYLocation, MagnetHeight, MagnetWidth)
    for i, enemy in pairs(self.enemy_list) do
      EXLocation, EYLocation, EnemyHeight, EnemyWidth = self.enemy_list[i]:getEnemyProperties()
      if EXLocation + EnemyWidth > LXLocation
      and EXLocation < LXLocation + MagnetWidth
      and EYLocation + EnemyHeight > LYLocation
      and EYLocation < LYLocation + MagnetHeight then
        if EXLocation - LXLocation < 10 and EXLocation - LXLocation > -10 then
          print("L Perfect!")
          for j=1,5 do
            self.score = self.score + self.enemy_list[i].point
          end
          self.enemy_list[i].point = 0
          -- include this if you want the block to disappear
          self.enemy_list[i]:begone()
          self.hit()

        else
          print("L Good!")
          self.score = self.score + self.enemy_list[i].point
          self.enemy_list[i].point = 0
          -- include this if you want the block to disappear
          self.enemy_list[i]:begone()
          self.hit()
        end
      end
    end
  end

  function Levels:resolveRCollisions(RXLocation, RYLocation, MagnetHeight, MagnetWidth)
      for i, enemy in pairs(self.enemy_list) do
        EXLocation, EYLocation, EnemyHeight, EnemyWidth = self.enemy_list[i]:getEnemyProperties()
        if EXLocation + EnemyWidth > RXLocation
        and EXLocation < RXLocation + MagnetWidth2
        and EYLocation + EnemyHeight > RYLocation
        and EYLocation < RYLocation + MagnetHeight2 then
          if EXLocation - RXLocation < 10 and EXLocation - RXLocation > -10 then
            print("R Perfect!")
            for j=1,5 do
              self.score = self.score + self.enemy_list[i].point
            end
            self.enemy_list[i].point = 0
            -- include this if you want the block to disappear
            self.enemy_list[i]:begone()
            self.hit()

          else
            print("R Good!")
            self.score = self.score + self.enemy_list[i].point
            self.enemy_list[i].point = 0
            -- include this if you want the block to disappear
            self.enemy_list[i]:begone()
            self.hit()

          end
        end
      end
    end
