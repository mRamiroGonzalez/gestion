ressources={}
function ressources:new(o)
  r = o or {}
  r.wood = 0
  r.stone = 0
  r.food = 0

  r.building_wood = 1
  r.building_stone = 2
  r.building_food = 3

  setmetatable(o, self)
  self.__index = self
  return r
end

function ressources:show()
  local x = flr(cam.x/8)*8 + 13*8 + 1
  local y = flr(cam.y/8)*8 + 1

  print(self.food,  x, y + 13*8, 7)
  print(self.stone, x, y + 14*8, 7)
  print(self.wood,  x, y + 15*8, 7)
end

function ressources:update()
  local refresh_value = flr(30 / const.ressources_updates_per_second)
  if ((counter % refresh_value) == 0) then
    self.wood += self.building_wood
    self.stone += self.building_stone
    self.food += self.building_food
  end
end



function update_ressources()
  ressources:update()
end

function print_ressources()
  ressources:show()
end