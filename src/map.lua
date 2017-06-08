function draw_map(var)
 map(0, 0, 0, 0, 128, 32)
end

cam_offset_y = nil

-- 0x1e80 is the starting address of the 3rd sprite sheet
function replace_tiles()
  if cam_offset_y then
    memcpy(0x2000 + cam_offset_y, 0x1e80, 128)
    memcpy(0x2000 + cam_offset_y + 128, 0x1f00, 128)
    memcpy(0x2000 + cam_offset_y + 256, 0x1f80, 128)
  end
end

function remove_tiles() 
  cam_offset_y =  (flr(cam.y/8) + 13) * 128
  memcpy(0x1e80, 0x2000 + cam_offset_y, 128)
  memcpy(0x1f00, 0x2000 + cam_offset_y + 128, 128)
  memcpy(0x1f80, 0x2000 + cam_offset_y + 256, 128)
end

function on_screen(x, y)
  if ((cam.x-8 <= x and x < (cam.x + 128)) and (cam.y <= y and y <= (cam.y + 104))) return true
  return false
end

function place_empty(x, y, size_x, size_y)
  if (size_x == 1 and size_y == 1) then
    return is_tile_empty(x, y)
  end
  if (size_x == 2 and size_y == 2) then
    return is_tile_empty(x, y) and is_tile_empty(x+1, y) and is_tile_empty(x, y+1) and is_tile_empty(x+1, y+1)
  end
end

function is_tile_empty(x, y)
  return fget(mget(x, y), const.flag_can_placed_on_top)
end

function get_map_tile_size(id)
  if (id == 1) return {x = 2, y = 2}
  if (id == 2) return {x = 2, y = 2}
  if (id == 3) return {x = 2, y = 2}
  if (id == 4) return {x = 2, y = 2}
  return {x = 1, y = 1}
end

function can_place()
  local size = get_map_tile_size(mouse.item)
  local mx = flr(mouse.x/8)
  local my = flr(mouse.y/8)

  -- verify if 
  --   something is below
  --   or we are deleting an entity
  --   or we are replacing something on a wall
  -- and that the action is on screen
  -- and that an item is selected
  if (place_empty(mx, my, size.x, size.y) or mouse.item == const.tile_remove or replace_wall_by_door(mx, my)) then
    if (on_screen(mouse.x, mouse.y)) then
      if (mouse.item != 0) then
        return true
      end
    end
  end
  return false
end

function replace_wall_by_door(x, y)
  return mget(x, y) >= 144 and mget(x,y) <= 156 and mouse.item == 7
end