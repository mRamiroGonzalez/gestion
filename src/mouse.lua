mouse={}
function mouse:new(o)
  m = o or {}
  m.x = stat(const.mouse_x)
  m.y = stat(const.mouse_y)
  m.click = 0
  m.item = 0
  m.place = false
  m.icon = 16
  m.selection_icon = 17

  setmetatable(o, self)
  self.__index = self
  return m
end

function mouse:draw()
  local r_x = (self.x % 8)
  local r_y = (self.y % 8)

  if (self.item != 0) spr(self.item, self.x - r_x, self.y - r_y)
  spr(self.selection_icon, self.x - r_x, self.y - r_y)
  spr(self.icon, self.x, self.y)
end


function mouse:update()
  self.x = flr(stat(const.mouse_x) + cam.x)
  self.y = flr(stat(const.mouse_y) + cam.y)
  self.click = stat(const.mouse_click)
end

function mouse:reset()
  mouse.item = 0
  mouse.place = 0
end

function mouse:get_tile()
  return {x = flr(self.x/8), y = flr(self.y/8), id = mget(flr(self.x/8), flr(self.y/8))}
end


-- client

function get_mouse_tile()
  return mouse:get_tile()
end

function draw_mouse()
  mouse:draw()
end

function update_mouse()
  mouse:update()
end

function reset_mouse()
  mouse:reset()
end