function handle_inputs()
  handle_buttons()
  handle_clicks()
end

function handle_buttons()
  if (btn(0)) move_camera(0)
  if (btn(1)) move_camera(1)
  if (btn(2)) move_camera(2)
  if (btn(3)) move_camera(3)
  if (btn(4)) reset_mouse()
end

function handle_clicks()
  if (mouse.click == 0 and not mouse.place) mouse.place = true

  if (mouse.click == 1 and mouse.place) then
    local tile = get_mouse_tile()

    if fget(tile.id, const.flag_can_be_selected)then
      -- select the tile to take in the mouse
      if (tile.id == 21) move_camera(0)
      if (tile.id == 19) move_camera(1)
      if (tile.id == 18) move_camera(2)
      if (tile.id == 20) move_camera(3)
      if (fget(tile.id, const.flag_can_be_placed)) mouse.item = tile.id
      if (tile.id == const.tile_cancel) reset_mouse()
    else
      if (can_place()) then
        -- place the item and loads it
        mset(tile.x, tile.y, mouse.item)
        load_entity(tile.x, tile.y)
        update_entities_force()

        -- replace the bomb with a default tile
        local tile = get_mouse_tile()
        if (mget(tile.x, tile.y) == const.tile_remove) then
          mset(tile.x, tile.y, const.tile_default)
          update_connected_textures(const.tile_remove, tile.x, tile.y)
        end
        mouse.place = false
      end
    end
  end
end