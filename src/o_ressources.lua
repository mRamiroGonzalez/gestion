ressources={}
function ressources:new(o)
  r = o or {}
  r.wood = 0
  r.stone = 0
  r.people = 0

  r.building_wood = 1
  r.building_stone = 2
  r.building_people = 3

  setmetatable(o, self)
  self.__index = self
  return r
end

function ressources:change(ressource, quantity)
  if (ressource == "wood") self.wood += quantity
  if (ressource == "stone") self.stone += quantity
  if (ressource == "people") self.people += quantity
end

function ressources:show()
  local x = flr(cam.x/8)*8 + 13*8 + 1
  local y = flr(cam.y/8)*8 + 1

  print(self.wood, x, y + 13*8, 7)
  print(self.stone, x, y + 14*8, 7)
  print(self.people, x, y + 15*8, 7)
end

function ressources:update()
  local refresh_value = flr(30 / const.ressources_updates_per_second)
  if ((counter % refresh_value) == 0) then
    self.wood += self.building_wood
    self.stone += self.building_stone
    self.people += self.building_people
  end
end



function update_ressources()
  ressources:update()
end

function print_ressources()
  ressources:show()
end