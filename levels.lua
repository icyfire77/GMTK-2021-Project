Levels = Object:extend()

function Levels:new()
    require "enemy"
    self.level = 0
    self.count = 0
    self.score = 0
    self.enemy_list = {}
    self.timings = {
        {2, 2, 2.6, 2.6, 4, 4, 4.6, 4.6, 6, 6, 6.6, 6.6, 8, 8, 8.6, 8.6, 10, 10, 10.6, 10.6, 12, 12, 12.6, 12.6, 14, 14, 14.6, 14.6, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20, 20.5, 21, 21.5, 22, 23, 24, 25, 26, 27, 28, 29, 10000},
        {2, 2, 2.6, 2.6, 4, 4, 4.6, 4.6, 6, 6, 6.6, 6.6, 8, 8, 8.6, 8.6, 10, 10, 10.6, 10.6, 12, 12, 12.6, 12.6, 14, 14.5, 15, 15.5, 16, 16.5, 17, 17.5, 10000}
    }
    self.positions = {
        {0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.65, 0.35, 0.55, 0.45, 0.2, 0.25, 0.3, 0.25, 0.3, 0.35, 0.4, 0.5, 0.55, 0.6, 0.7, 0.8, 0.2, 0.7, 0.4, 0.1, 0.9, 0.6, 0.5, 0.5, -1000},
        {0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.65, 0.35, 0.55, 0.45, 0.2, 0.25, 0.3, 0.25, 0.3, 0.35, 0.4, 0.45, -1000}
    }
    self.bpm = {
        120,
        128
    }
end

-- Set the level to 1 before generate
function Levels:generate(t)
    enemy_size = 20
    if  self.count < #self.timings[self.level] then
        while t + 0 >= self.timings[self.level][self.count + 1]*60/self.bpm[self.level] do
            self.count = self.count + 1
            x_pos = windowWidth * self.positions[self.level][self.count] - enemy_size/2
            y_pos = 0 -- for now
            curr_enemy = Enemy(x_pos, y_pos, enemy_size, enemy_size, 500, t)
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
end

function Levels:resolveLCollisions(LXLocation, LYLocation, MagnetHeight, MagnetWidth)
    for i, enemy in pairs(self.enemy_list) do
      EXLocation, EYLocation, EnemyHeight, EnemyWidth = self.enemy_list[i]:getEnemyProperties()
      if EXLocation + EnemyWidth > LXLocation
      and EXLocation < LXLocation + MagnetWidth
      and EYLocation + EnemyHeight > LYLocation
      and EYLocation < LYLocation + MagnetHeight then
        print("L Collision")
        self.score = self.score + self.enemy_list[i].point
        self.enemy_list[i].point = 0
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
          self.score = self.score + self.enemy_list[i].point
          self.enemy_list[i].point = 0
        end
      end
    end
