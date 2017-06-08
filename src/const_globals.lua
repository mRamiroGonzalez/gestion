  -- flags
  -- 0: 
  -- 1: a tile can be placed on top
  -- 2: can be selected
  -- 3: can be placed
  -- 4: is part of a connected texture (walls)
  -- 5: 

const = {
  mouse_x = 32,
  mouse_y = 33,
  mouse_click = 34,

  tile_default = 33,
  tile_remove = 23,
  tile_cancel = 22,
  tile_block = 24,

  entity_updates_per_second = 30,
  entity_draws_per_second = 2,

  camera_max_x = 128 * 7, -- 1024 tiles horizontal, minus 128 for upper left corner
  camera_max_y = 128 + (3 * 8), -- 128 tiles, plus 3 for the menu

  map_playable_width = 127,
  map_playable_height = 31,

  flag_can_placed_on_top = 1,
  flag_can_be_selected = 2,
  flag_can_be_placed = 3,
  flag_can_connect = 4
}

function init_globals()
  entities = {}
  menu = {}
  removed_tiles = {}
  cam = cam:new({})
  mouse = mouse:new({})
  counter = 0
end