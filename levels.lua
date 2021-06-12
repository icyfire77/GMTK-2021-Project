Levels = Object:extend()

function Levels:new()
    require "enemy"
    self.level = 0
    self.count = 0
    self.enemy_list = {}
    self.timings = {
        {0, 0.5, 1, 1.5}
    }
    self.positions = {
        {0.5, 0.6, 0.7, 0.8}
    }
    self.bpm = {
        128
    }
end

-- Set the level to 1 before generate
function Levels:generate(t)
    if  self.count < #self.timings[self.level] then
        while t >= self.timings[self.level][self.count + 1]*60/self.bpm[self.level] do
            self.count = self.count + 1
            x_pos = windowWidth * self.positions[self.level][self.count]
            y_pos = 0 -- for now
            curr_enemy = Enemy(x_pos, y_pos, 10, 10, 500)
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
end

function Levels:resolveCollisions(LXLocation, LYLocation, RXLocation, RYLocation, MagnetHeight, MagnetWidth)
    for i, enemy in pairs(self.enemy_list) do
      EXLocation, EYLocation, EnemyHeight, EnemyWidth = self.enemy_list[i]:getEnemyProperties()
      if EXLocation + EnemyWidth > LXLocation
      and EXLocation < LXLocation + MagnetWidth
      and EYLocation + EnemyHeight > LYLocation
      and EYLocation < LYLocation + MagnetHeight or
      EXLocation + EnemyWidth > RXLocation
      and EXLocation < RXLocation + MagnetWidth2
      and EYLocation + EnemyHeight > RYLocation
      and EYLocation < RYLocation + MagnetHeight2 then
        print("Collision")
      end
    end
  end
  