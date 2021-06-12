Levels = Object:extend()

function Levels:new()
    require "enemy"
    self.level = 0
    self.count = 0
    self.score = 0
    self.enemy_list = {}
    self.timings = {
        {2, 2, 2.6, 2.6, 4, 4, 4.6, 4.6, 6, 6, 6.6, 6.6, 8, 8, 8.6, 8.6, 10, 10, 10.6, 10.6, 12, 12, 12.6, 12.6, 14, 14.5, 15, 15.5, 16, 16.5, 17, 17.5, 10000}
    }
    self.positions = {
        {0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.65, 0.35, 0.55, 0.45, 0.2, 0.25, 0.3, 0.25, 0.3, 0.35, 0.4, 0.45, -1000}
    }
    self.bpm = {
        128
    }
end

-- Set the level to 1 before generate
function Levels:generate(t)
    enemy_size = 20
    if  self.count < #self.timings[self.level] then
        while t >= self.timings[self.level][self.count + 1]*60/self.bpm[self.level] do
            self.count = self.count + 1
            x_pos = windowWidth * self.positions[self.level][self.count] - enemy_size/2
            y_pos = 0 -- for now
            curr_enemy = Enemy(x_pos, y_pos, enemy_size, enemy_size, 500)
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
    self.enemy_list[i]:update(dt)
    if self.enemy_list[i].y > windowHeight + 50 then
      table.remove(self.enemy_list, i)
    end
  end

end

function Levels:draw()
    for i, enemy in pairs(self.enemy_list) do
      self.enemy_list[i]:draw()
    end
end

function Levels:setLevel(lvl)
    self.level = lvl
    self.score = 0
end

function Levels:resolveLCollisions(LXLocation, LYLocation, MagnetHeight, MagnetWidth)
    for i, enemy in pairs(self.enemy_list) do
      EXLocation, EYLocation, EnemyHeight, EnemyWidth = self.enemy_list[i]:getEnemyProperties()
      if EXLocation + EnemyWidth > LXLocation
      and EXLocation < LXLocation + MagnetWidth
      and EYLocation + EnemyHeight > LYLocation
      and EYLocation < LYLocation + MagnetHeight then
        print("L Collision")
        self.enemy_list[i]:update(1000)
        self.score = self.score + 1
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
          print("R Collision")
          self.enemy_list[i]:update(1000)
          self.score = self.score + 1
        end
      end
    end
