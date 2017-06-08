function update_connected_textures(current_tile, x, y)
  if (is_a_wall(x-1, y) and not is_a_door(x-1, y)) mset(x-1,y, get_connected_texture(x-1, y))
  if (is_a_wall(x+1, y) and not is_a_door(x+1, y)) mset(x+1,y, get_connected_texture(x+1, y))
  if (is_a_wall(x, y-1) and not is_a_door(x, y-1)) mset(x,y-1, get_connected_texture(x, y-1))
  if (is_a_wall(x, y+1) and not is_a_door(x, y+1)) mset(x,y+1, get_connected_texture(x, y+1))
end

function get_connected_texture(x, y)
  if (is_connected(x-1, y) and is_connected(x+1, y) and is_connected(x, y-1) and is_connected(x, y+1)) return 156
  if (is_connected(x, y+1) and is_connected(x+1, y) and is_connected(x-1, y)) return 152
  if (is_connected(x, y-1) and is_connected(x, y+1) and is_connected(x+1, y)) return 155
  if (is_connected(x, y-1) and is_connected(x+1, y) and is_connected(x-1, y)) return 154
  if (is_connected(x, y-1) and is_connected(x, y+1) and is_connected(x-1, y)) return 153
  if (is_connected(x, y-1) and is_connected(x, y+1)) return 151
  if (is_connected(x, y-1) and is_connected(x-1, y)) return 149
  if (is_connected(x, y-1) and is_connected(x+1, y)) return 148
  if (is_connected(x-1, y) and is_connected(x+1, y)) return 150
  if (is_connected(x, y+1) and is_connected(x+1, y)) return 146
  if (is_connected(x, y+1) and is_connected(x-1, y)) return 147
  if (is_connected(x, y-1)) return 151
  if (is_connected(x, y+1)) return 151
  if (is_connected(x-1, y)) return 150
  if (is_connected(x+1, y)) return 150
  return 150
end

function is_connected(x, y)
  return fget(mget(x, y), const.flag_can_connect)
end

function is_a_wall(x, y)
  local tile = mget(x,y)
  return tile >= 144 and tile <= 156
end

function is_a_door(x, y)
  local tile = mget(x,y)
  return tile >= 157 and tile <= 158
end

function is_between_two_walls(x, y)
  local wall_l = is_a_wall(x-1, y) or is_a_door(x-1, y)
  local wall_r = is_a_wall(x+1, y) or is_a_door(x+1, y)
  local wall_u = is_a_wall(x, y-1) or is_a_door(x, y-1)
  local wall_d = is_a_wall(x, y+1) or is_a_door(x, y+1)

  if (wall_l and wall_r and wall_u and wall_d)      return 0
  if (wall_l and wall_r and not (wall_u or wall_d)) return 1
  if (wall_u and wall_d and not (wall_l or wall_r)) return 2
  return 0
end