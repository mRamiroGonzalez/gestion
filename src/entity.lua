entity={}
function entity:new(o)
  e = o or {}
  e.x = (o.x * 8) or 0
  e.y = (o.y * 8) or 0
  e.c = o.start_tile  -- current frame to display
  e.st = o.start_tile
  e.size = o.start_tile + o.size
  e.width = o.width
  e.height = o.height

  setmetatable(o, self)
  self.__index = self
  return e
end

function entity:draw()
  spr(self.c, self.x, self.y, self.width, self.height)
end

function entity:update()
  if (self:on_a_bomb()) then
    if (self:on_screen()) then
      self:replace_with_default()
      self:remove_from_entities()
    end
  else
    local refresh_value = flr(60 / const.entity_draws_per_second)
    if ((counter % refresh_value) == 0) then
      self:animate(2)
    end
  end
end

function entity:on_screen()
  return on_screen(self.x, self.y)
end

function entity:on_a_bomb()
  local tx = flr(self.x / 8)
  local ty = flr(self.y / 8)
  return (mget(tx, ty) == const.tile_remove) or (mget(tx+1, ty) == const.tile_remove) or (mget(tx, ty+1) == const.tile_remove) or (mget(tx+1, ty+1) == const.tile_remove)
end

function entity:animate(speed)
  self.c += speed
  if (self.c > self.size) then
    self.c = self.st
  end
end

function entity:replace_with_default()
  local tx = flr(self.x / 8)
  local ty = flr(self.y / 8)
  mset(tx  , ty,   const.tile_default)
  mset(tx+1, ty,   const.tile_default)
  mset(tx  , ty+1, const.tile_default)
  mset(tx+1, ty+1, const.tile_default)
end

function entity:remove_from_entities()
  del(entities, self)
end


-- client

function draw_entities()
  for e in all(entities) do e:draw() end
end

function update_entities()
  local refresh_value = flr(60 / const.entity_updates_per_second)
  if ((counter % refresh_value) == 0) then
    for e in all(entities) do e:update() end
  end
end

function update_entities_force()
  for e in all(entities) do e:update() end
end

function load_entities()
  for xi = 0, const.map_playable_width, 1 do
    for yi = 0, const.map_playable_height, 1 do
      load_entity(xi, yi)
    end
  end
end

function load_entity(xi, yi)
  local anim = {start_tile = 0, size = 0}
  local current_tile = mget(xi, yi)

  -- true entities
  if (current_tile == 1) anim = {start_tile = 64, size = 2, width = 2, height = 2}
  if (current_tile == 2) anim = {start_tile = 96, size = 2, width = 2, height = 2}
  if (current_tile == 3) anim = {start_tile = 68, size = 2, width = 2, height = 2}
  if (current_tile == 4) anim = {start_tile = 100, size = 2, width = 2, height = 2}
  
  -- not entities, replaced with other tiles
  if (current_tile == 9) mset(xi, yi, 48)
  if (current_tile == 7) then
    local surrounding_walls = is_between_two_walls(xi, yi)
    if (surrounding_walls == 1) mset(xi, yi, 157)
    if (surrounding_walls == 2) mset(xi, yi, 158)
    if (surrounding_walls == 0) then
      mset(xi, yi, get_connected_texture(xi, yi))
      update_connected_textures(current_tile, xi, yi)
    end
  end
  if (current_tile == 8) then
    mset(xi, yi, get_connected_texture(xi, yi))
    update_connected_textures(current_tile, xi, yi)
  end

  if (anim.start_tile != 0) then
    add(entities, entity:new({ x=xi, y=yi, start_tile=anim.start_tile, size=anim.size, width=anim.width, height=anim.height}))
    mset(xi, yi, const.tile_block)
    if (anim.width == 2 and anim.height == 2) then 
      mset(xi + 1, yi    , const.tile_block)
      mset(xi    , yi + 1, const.tile_block)
      mset(xi + 1, yi + 1, const.tile_block)
    end
  end
end