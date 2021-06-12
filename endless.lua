Endless = Object:extend()

function Endless:new(num_enemies, rate)
    require "enemy"
    self.num_enemies = num_enemies
    self.rate = rate
    self.enemy_list = {}
end

function Endless:generate()
  for i = 1, self.num_enemies, 1
  do
      x_random = math.random(windowWidth)
      y_random = math.random(-100 * self.num_enemies)
      curr_enemy = Enemy(x_random, y_random, 10, 10)
      table.insert(self.enemy_list, curr_enemy)
      print("enemy ", i, "added")
  end
end

function Endless:update(dt)
  for i, enemy in pairs(self.enemy_list) do
    self.enemy_list[i]:update(dt)
  end
end

function Endless:draw()
    for i, enemy in pairs(self.enemy_list) do
      self.enemy_list[i]:draw()
    end
end

function Endless:searchList(index)
  return self.enemy_list[index]:getEnemyProperties()
end
