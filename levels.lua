Levels = Object:extend()

function Levels:new()
    require "enemy"
    self.level = 0
    self.count = 0
    self.score = 0
    self.enemy_list = {}
    self.timings = {
{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 10000},
    }
    self.positions = {
{0.782937600401462, 0.5691880442, 0.06932290032, 0.4463979967, 0.4557379053, 0.8810426251, 0.5994212214, 0.1706195278, 0.6283674574, 0.4096418754, 0.7958981305, 0.1692054242, 0.5718939251, 0.3477179515, 0.1003655075, 0.2826569284, 0.01604751453, 0.1278217493, 0.02269243134, 0.1298077363, 0.616351447, 0.7627963548, 0.4399137165, 0.136799057, 0.110420593, 0.818907256, 0.9261796964, 0.2907071472, 0.672613701, 0.001762984382, 0.1683431201, 0.1160224865, 0.1686081658, 0.03535397375, 0.542286808, 0.02550050517, 0.1100984386, 0.3709837441, 0.3518538208, 0.5064738954, 0.114702536, 0.2755611032, 0.06524946289, 0.569537071, 0.5872935943, 0.01766794741, 0.1230420795, 0.5085831349, 0.1563563045, 0.1950119911, 0.5373981823, 0.2994948898, 0.1226009788, 0.7283196752, 0.5539441457, 0.8993606115, 0.8069506255, 0.6844191941, 0.1056555946, 0.2989068076, 0.2211493079, 0.8852093388, 0.6524324747, 0.4279096992, 0.9266231538, 0.2094051681, 0.2705265752, 0.9166674152, 0.2958574894, 0.6003962682, 0.5327450343, 0.2761860729, 0.6454372491, 0.05624976198, 0.8033622048, 0.2755521431, 0.8710298688, 0.2968340115, 0.06092921924, 0.1670345954, 0.2819733943, 0.3782360422, 0.2576789144, 0.937780094, 0.306764406, 0.2560893546, 0.5259815326, 0.9515354198, 0.6206243987, 0.1871253517, 0.2503140991, 0.1846511007, 0.0324549272, 0.9022062617, 0.1374644976, 0.7576904373, 0.1608752926, 0.684292957, 0.9381993219, 0.6172893032, 0.527669191, 0.8412462583, 0.4003815065, 0.03248120459, 0.2018494917, 0.5760558655, 0.3665326224, 0.03552342566, 0.5386833376, 0.9260361698, 0.6680916584, 0.05932977021, 0.8754021582, 0.2677235046, 0.6141307304, 0.8019358788, 0.2689545746, 0.8656547868, 0.4240450009, 0.7829936615, 0.491042347, 0.08090291015, 0.9117429587, 0.1481113352, 0.5318130157, 0.1491893339, 0.09312013144, 0.02392604177, 0.8059649291, 0.888589631, 0.1591076744, 0.1301164047, 0.1036539844, 0.3032934703, 0.433344894, 0.4141325595, 0.08347356067, 0.8125753194, 0.5165325779, 0.1902414677, 0.765912122, 0.7530776011, 0.8087817165, 0.6365559819, 0.05307617543, 0.8777037116, 0.9967803809, 0.5320358827, 0.7740983663, 0.8058630562, 0.8943587643, 0.800019947, 0.1355339462, 0.7675059036, 0.233040794, 0.7656680668, 0.7421813128, 0.5273312818, 0.613428075, 0.03176302613, 0.5461452021, 0.07574611072, 0.8487701087, 0.5306414477, 0.1805940009, 0.5295992507, 0.3588320521, 0.6195943606, 0.1395454195, 0.6984096279, 0.1051798727, 0.05289751268, 0.1761474073, 0.9407524813, 0.7982595041, 0.2857021634, 0.1093045246, 0.2606636967, 0.752155639, 0.8433375537, 0.9521319341, 0.07536673141, 0.8146724494, 0.4241462531, 0.9056029639, 0.7233228382, 0.2583871598, 0.9947939411, 0.296888226, 0.5755497343, 0.3825849729, 0.3840659459, 0.9842674733, 0.5633498714, 0.8464912375, 0.7844823542, 0.09912829935, 0.04203430246, 0.4309754642, 0.1306345879, 0.2504480245, 0.1729237976, 0.008908551328, 0.5389663129, 0.4782886369, 0.4248538175, 0.9936133078, 0.8657917447, 0.3102171566, 0.3716057776, 0.4303556044, 0.9686651059, 0.248196105, 0.6931315587, 0.1975814226, 0.4407847424, 0.8933729079, 0.1761345975, 0.4926131482, 0.4289364959, 0.702328071, 0.5535150137, 0.890775803, 0.6425502867, 0.06072658199, 0.2223826789, 0.7874322207, 0.8147652144, 0.9589482111, 0.2367864843, 0.9591634811, 0.6859677556, 0.05915665632, 0.4840040665, 0.3133392076, 0.04608885891, 0.3543989027, 0.6221812407, 0.6345798908, 0.4940154078, 0.9377100917, 0.1823055918, 0.2821209812, 0.3507921682, 0.622831578, 0.2189444562, 0.343847106, 0.5978605577, 0.2880321502, 0.03187224819, 0.7107714436, 0.8024009064, 0.8506564788, 0.7746579602, 0.8999941782, 0.738915117, 0.7224061195, 0.2164784032, 0.2246809404, 0.8195069517, 0.4439927041, 0.5298685987, 0.08636065331, 0.5048877676, 0.9526842538, 0.7398158009, 0.7478493255, 0.5839552914, 0.5974001312, 0.388548802, 0.9343647363, 0.5818638765, 0.5833909345, 0.045569793, 0.00590444915, 0.5848246742, 0.002174334976, 0.5239211555, 0.2457172813, 0.4544445453, 0.9822794718, 0.05137487872, 0.01770685947, 0.745232944, 0.7824855993, 0.1891778045, 0.1598626369, 0.6359760736, 0.8416239005, 0.9911808955, 0.001322404351, 0.8389982747, 0.8976435565, 0.752626288, 0.8174280525, 0.7609007464, 0.2935266783, 0.7105611865, 0.3701435184, 0.1541876374, 0.4987685565, 0.2267927729, 0.4204625486, 0.1212608134, 0.6925238998, 0.3094938404, 0.7449409192, 0.6105837268, 0.9781509053, 0.8110141139, 0.2402463987, 0.4793862493, 0.4287691644, 0.2771473227, 0.1576264747, 0.78810164, 0.6995795157, 0.2170498957, 0.3734529373, 0.238798007, 0.3850770355, 0.5132017644, 0.8725090325, 0.5731863639, 0.6479208775, 0.7972458299, 0.2974435964, 0.3053577625, 0.9011079956, 0.8802372072, 0.5008239518, 0.3802226702, 0.4862299135, 0.7447795537, 0.5254772812, 0.2206955571, 0.3579754086, 0.1817199261, 0.3343178822, 0.1549883614, 0.7586736947, 0.8855203124, 0.9126158585, 0.3999465533, 0.7465564491, 0.7101180795, 0.07367004334, 0.6171821619, 0.2275494846, 0.8310335514, 0.4131064742, 0.5558279589, 0.8327874552, 0.7596781715, 0.3775309782, 0.449057727, 0.5826782433, 0.5122618475, 0.3400223028, 0.6410877299, 0.7832258963, 0.7483933294, 0.9079605457, 0.3871946829, 0.01145481394, 0.3634133616, 0.4279427195, 0.8913559971, 0.3641592266, 0.8436946529, 0.7980457462, 0.4244382838, 0.3678362723, 0.6755890413, 0.2494544165, 0.8004305787, 0.0775427788, 0.2363970158, 0.7174802438, 0.579038664, 0.9285492693, 0.8896798524, 0.7862544623, 0.1100278451, 0.8470471389, 0.4574306592, 0.961886408, 0.9380210722, 0.9747980167, 0.8480652162, 0.205636667, 0.1460302025, 0.1174969409, 0.3818893239, 0.2416613445, 0.9318183408, 0.6877540217, 0.2746441167, 0.1431426503, 0.08326130329, 0.4809818292, 0.814926909, 0.09612805899, 0.04719684944, -1000},        {0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.8, 0.2, 0.7, 0.3, 0.65, 0.35, 0.55, 0.45, 0.2, 0.25, 0.3, 0.25, 0.3, 0.35, 0.4, 0.45, -1000}
    }
    self.bpm = {
        120,
        128
    }
end

-- Set the level to 1 before generate
function Levels:generate(t)
    enemy_sizew, enemy_sizeh = 60, 10
    if  self.count < #self.timings[self.level] then
        while t + 0 >= self.timings[self.level][self.count + 1]*60/self.bpm[self.level] do
            self.count = self.count + 1
            x_pos = windowWidth * self.positions[self.level][self.count] - enemy_sizew/2
            y_pos = 0 -- for now
            curr_enemy = Enemy(x_pos, y_pos, enemy_sizew, enemy_sizeh, 500, t)
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
        if EXLocation - LXLocation < 10 and EXLocation - LXLocation > -10 then
          print("L Perfect Collision")
          self.score = self.score + self.enemy_list[i].point
          self.score = self.score + self.enemy_list[i].point
          self.score = self.score + self.enemy_list[i].point
          self.score = self.score + self.enemy_list[i].point
          self.score = self.score + self.enemy_list[i].point
          self.enemy_list[i].point = 0
          -- include this if you want the block to disappear
          self.enemy_list[i]:begone()
        else
          print("L Collision")
          self.score = self.score + self.enemy_list[i].point
          self.enemy_list[i].point = 0
          -- include this if you want the block to disappear
          self.enemy_list[i]:begone()
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
            print("R Perfect Collision")
            self.score = self.score + self.enemy_list[i].point
            self.score = self.score + self.enemy_list[i].point
            self.score = self.score + self.enemy_list[i].point
            self.score = self.score + self.enemy_list[i].point
            self.score = self.score + self.enemy_list[i].point
            self.enemy_list[i].point = 0
            -- include this if you want the block to disappear
            self.enemy_list[i]:begone()
          else
            print("R Collision")
            self.score = self.score + self.enemy_list[i].point
            self.enemy_list[i].point = 0
            -- include this if you want the block to disappear
            self.enemy_list[i]:begone()
          end
        end
      end
    end
