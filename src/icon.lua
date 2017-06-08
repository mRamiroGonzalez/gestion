icon={}
function icon:new(o)
  i = o or {} 
  i.x = o.x or 0
  i.y = o.y or 0
  i.sprite = o.sprite or 0

  setmetatable(o, self)
  self.__index = self
  return i
end

function icon:draw()
  mset(flr(cam.x/8) + self.x, flr(cam.y/8) + 13 + self.y, self.sprite)
  spr(self.sprite, flr(cam.x) + (self.x * 8), flr(cam.y + (104 + (self.y * 8))))
end


-- client

function add_icon(x, y, sprite)
  add(menu, icon:new({x=x, y=y, sprite=sprite}))
end

function draw_menu()
  rectfill(cam.x, cam.y + 104, cam.x + 128, cam.y + 104 + 24, 0)
  remove_tiles()
  for icon in all(menu) do icon:draw() end
  spr(mouse.item, cam.x +(7*8), cam.y+(14*8))
  rect(cam.x, cam.y + 104, cam.x + 127, cam.y + 104 + 23, 8)
end

function init_menu()
  add_icon(0, 0, 1)
  add_icon(1, 0, 2)
  add_icon(2, 0, 3)
  add_icon(3, 0, 4)
  add_icon(4, 0, 9)

  add_icon(0, 1, 5)
  add_icon(1, 1, 6)
  add_icon(2, 1, 7)
  add_icon(3, 1, 8)

  add_icon(7, 0, 18)
  add_icon(8, 1, 19)
  add_icon(7, 2, 20)
  add_icon(6, 1, 21)
  add_icon(6, 2, 22)
  add_icon(8, 2, 23)
end
