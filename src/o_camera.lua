cam={}
function cam:new(o)
  cam = o or {}
  cam.x = o.x or 0
  cam.y = o.y or 0

  setmetatable(o, self)
  self.__index = self
  return cam
end

function cam:draw()
  camera(cam.x, cam.y)
end

function cam:move_up()
  if self.y - 8 > 0 then self.y -= 8
  elseif self.y - 8 <= 0 then self.y = 0
  end
end

function cam:move_down()
  if self.y < const.camera_max_y then self.y += 8
  elseif self.y + 8 >= const.camera_max_y then self.y = const.camera_max_y
  end
end

function cam:move_left()
  if self.x - 8 > 0 then self.x -= 8
  elseif self.x - 8 <= 0 then self.x = 0
  end
end

function cam:move_right()
  if self.x + 8 < const.camera_max_x then self.x += 8
  elseif self.x + 8 >= const.camera_max_x then self.x = const.camera_max_x
  end
end


-- client

function move_camera(direction)
  if (direction == 0) cam:move_left()
  if (direction == 1) cam:move_right()
  if (direction == 2) cam:move_up()
  if (direction == 3) cam:move_down()
end

function draw_camera()
  cam:draw()
end